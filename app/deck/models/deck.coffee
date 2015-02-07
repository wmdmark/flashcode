CardCollection = require("card/models/card-collection")

module.exports = class Deck extends Parse.Object
  className: "Deck"
  defaults:
    name: ""
    description: ""

  initialize: ->
    @cards = new CardCollection([], deckID: @id)