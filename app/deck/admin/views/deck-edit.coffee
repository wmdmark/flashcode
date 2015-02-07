Card = require("card/models/card")

module.exports = class DeckEditView extends Marionette.CompositeView
  template: require("./templates/deck-edit")
  className: "deck-edit-view primary-page"
  childView: require("./card-list-item")
  childViewContainer: ".card-list-container"

  behaviors:
    Bind: {}

  triggers:
    "click .add-card": "add:card"
    "click .edit-deck": "edit:deck"
    "click .play-deck": "play:deck"

  initialize: ->
    @collection = @model.cards
    @collection.fetch()

  getEmptyView: ->
    require("./card-list-empty")

  onAddCard: ->
    card = new Card
      deck: @model
      user: App.request("get:user")

    card.on "sync", =>
      @collection.add(card)
      card.off "sync"

    App.execute("show:card:form", card)

  onEditDeck: ->
    App.execute("show:deck:form", @model)

  onPlayDeck: ->
    App.navigate("/deck/#{@model.id}/play", trigger: yes)
