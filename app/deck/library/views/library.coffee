Deck = require("deck/models/deck")
DeckCollection = require("deck/models/deck-collection")

module.exports = class LibraryView extends Marionette.CompositeView
  template: require("./templates/library")
  className: "library-view primary-page"
  childView: require("./deck-thumb")
  childViewContainer: ".decks-thumb-container"

  triggers:
    "click .add-deck": "add:deck"

  initialize: ->
    @collection = new DeckCollection([], @options)
    @collection.fetch()

  onAddDeck: ->
    deck = new Deck(owner: App.request("get:user"))
    @listenTo deck, "sync", ->
      @collection.add(deck)
    App.execute("show:deck:form", deck)

  serializeData: ->
    data = super()
    data.user = App.request("get:user")?.toJSON()
    data
