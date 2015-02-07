Card = require("card/models/card")
CardView = require("./views/card")

module.exports = App.module "CardPlayModule", (Global, App, Backbone, Marionette, $, _) ->
  @startWithParent = false