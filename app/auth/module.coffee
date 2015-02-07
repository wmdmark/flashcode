User = require("./models/user")
SignUpInView = require("./views/sign-up-in")

module.exports = App.module "AuthModule", (Global, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class Global.Router extends Marionette.AppRouter
    appRoutes:
      "auth": "authenticate"

  API =
    authenticate: ->
      App.execute("show:auth:modal")

  App.addInitializer ->
    new Global.Router controller: API
    # setup the app bar

  App.reqres.setHandler "get:user", ->
    return Parse.User.current()

  App.commands.setHandler "show:auth:modal", (next=null)->
    view = new SignUpInView(next: next)
    if next
      App.navigate("/auth")
      view.once "authenticated", ->
        _.defer ->
          App.navigate(next, trigger: yes)

    App.modal.show(view)    

  App.reqres.setHandler "guarantee:user", (email, password)->
    # Get's or creates a user with the given credentials
    d = new $.Deferred()
    email = email.toLowerCase()
    query = new Parse.Query(Parse.User)
    query.equalTo("username", email)
    query.first()
      .then (user)->
        if user?
          App.request("sign:in", email, password)
            .then (user)-> 
              d.resolve(user)
            .fail (err)-> 
              d.reject(err)
          return
        else
          user = new Parse.User()
          user.set
            username: email
            email: email
            password: password
          user.signUp()
            .then (user)-> 
              App.vent.trigger("session:authenticated", user)
              d.resolve(user)
            .fail (err)-> d.reject(err)
          return
      .fail (err)->
        d.reject(err)
    
    return d.promise()


  App.reqres.setHandler "sign:in", (username, password)->
    d = new $.Deferred()
    
    Parse.User.logIn(username, password)
      .then (user)->
        App.vent.trigger("session:authenticated", user)  
        d.resolve(user)
      .fail (err)-> d.reject(err)
    
    return d.promise()

  App.commands.setHandler "sign:out", ->
    user = App.request("get:user")
    if user
      Parse.User.logOut()
      App.vent.trigger("session:unauthenticated")


  