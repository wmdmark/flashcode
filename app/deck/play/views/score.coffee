module.exports = class ScoreView extends Marionette.ItemView
  template: require("./templates/score")
  className: "score-view"
  
  onShow: ->
    @binding = rivets.bind(@el, model: @model)

  onDestroy: ->
    @binding.unbind()

  serializeData:->
    data = super()
    data.card_total = @options.deck.cards.length
    data