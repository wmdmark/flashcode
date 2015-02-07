Deck = require("./deck")
module.exports = class DeckCollection extends Parse.Collection
  model: Deck

  initialize: ([], @options={})->
    if @options.filters
      @query = new Parse.Query(Deck)
      for key, val of @options.filters
        @query.equalTo(key, val)

  comparator: (deck)->
    !deck.get("featured") is yes