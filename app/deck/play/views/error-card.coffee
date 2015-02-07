module.exports = class ErrorCardView extends Marionette.ItemView
  template: require("./templates/error-card")
  className: "error-card-view card-view"

  initialize: ->
    @model = new Backbone.Model(message: @options.message)
