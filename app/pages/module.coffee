HomeView = require("./views/home")

module.exports = App.module "PagesModule", (Global, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class Global.Router extends Marionette.AppRouter
    appRoutes:
      "": "home"

  API =
    home: ->
      App.primary.show(new HomeView())

  App.addInitializer ->
    new Global.Router controller: API
    # setup the app bar


  