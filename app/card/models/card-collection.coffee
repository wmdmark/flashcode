Card = require("./card")
module.exports = class CardCollection extends Parse.Collection
  model: Card

  initialize: (models, @options={})->
    super(models)
    @_initQuery() if @options.deckID

  _initQuery: ->
    Deck = Parse.Object.extend("Deck")
    deck = new Deck()
    deck.id = @options.deckID
    @query = new Parse.Query(Card).equalTo("deck", deck)

  updateOrders: (orderData)->
    
