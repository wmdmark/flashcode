LibraryView = require("./views/library")

module.exports = App.module "DeckLibraryModule", (Library, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class Library.Router extends Marionette.AppRouter
    appRoutes:
      "library": "library"
      "library/featured": "featured"
      "library/mine": "libraryForUser"

  API =
    
    library: ->
      App.primary.show(new LibraryView())
    
    featured: ->
      App.primary.show(new LibraryView(filters: {"featured": yes}))

    libraryForUser: ->
      user = App.request("get:user")
      if user
        App.primary.show(new LibraryView(filters: {"owner": user}))
      else
        App.navigate("/library", trigger: yes)
      
  App.addInitializer ->
    new Library.Router controller: API
    # setup the app bar


  