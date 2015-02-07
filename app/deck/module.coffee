DeckCollection = require("./models/deck-collection")
Deck = require("./models/deck")

module.exports = App.module "DeckModule", (Global, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  require("./library/module").start()
  require("./play/module").start()
  require("./admin/module").start()

  decks = null
  App.reqres.setHandler "get:decks", (filters={})->
    # Loads all the decks
    decks = new DeckCollection()
    decks.fetch()

  App.reqres.setHandler "get:deck", (id)->
    deck = new Deck(id: id)
    deck.fetch()