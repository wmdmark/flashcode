AppBarView = require("pages/views/app-bar")

module.exports = do (Backbone, Marionette) ->
  
  App = new Marionette.Application    

  App.addRegions
    appBar: "#app-bar-region"
    primary: 
      selector: "#app-primary-region"
    modal:
      selector: "#app-modal-region"
      regionClass: require("lib/core/modal-region")

  App.addInitializer ->
    require("lib/behaviors/module").start()
    require("auth/module").start()
    require("card/module").start()
    require("deck/module").start()
    require("pages/module").start()
    require("card/admin/module").start()

  App.reqres.setHandler "set:url", (url)->
    Backbone.history.navigate(url, trigger: no)

  App.navigate = (url, trigger=no)->
    Backbone.history.navigate(url, trigger: trigger)    
    App.vent.trigger("navigate", url)

  App.nextURL = null
  App.setNextRoute = (url=null)->
    if not url
      url = Backbone.history.fragment
    App.nextURL = url

  App.getCurrentRoute = ->
    return Backbone.history.fragment

  App.navNext = ->
    if App.nextURL?
      url = Backbone.history.fragment
      if url isnt App.nextURL
        App.navigate(App.nextURL, trigger: yes)
        App.nextURL = null

  App.on "start", (options) ->
    FastClick.attach(document.body)
    if Backbone.history
      Backbone.history.start(pushState: yes)
      App.appBar.show(new AppBarView())
      App.vent.trigger("navigate", Backbone.history.fragment)    

  App