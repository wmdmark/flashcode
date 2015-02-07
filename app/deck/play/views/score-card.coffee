module.exports = class ScoreCardView extends Marionette.ItemView
  template: require("./templates/score-card")
  className: "card-view score-card-view"

  triggers:
    "click .replay": "replay"

  onShow: ->
    twttr.widgets.load()

  serializeData: ->
    data = super()
    data.session = @options.session.toJSON()
    data