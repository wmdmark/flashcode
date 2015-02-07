DeckView = require("./views/deck")
Session = require("./models/session")

module.exports = App.module "DeckPlayModule", (Global, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class Global.Router extends Marionette.AppRouter
    appRoutes:
      "deck/:id/play": "playDeck"

  API =
    playDeck: (id)->
      # TODO: show spinner
      App.request("get:deck", id)
        .then (deck)->
          App.execute("play:deck", deck)
        .fail (err)->
          alert("Error loading deck! #{err}")

  App.addInitializer ->
    new Global.Router controller: API
    # setup the app bar

  App.commands.setHandler "play:deck", (deck)->
    session = new Session()
    App.primary.show(new DeckView(model: deck, session: session))



  