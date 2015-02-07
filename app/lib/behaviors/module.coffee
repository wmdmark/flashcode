module.exports = App.module "Behaviors", (Behaviors, App, Backbone, Marionette, $, _) ->
  # Have to explicitly require the behaviors
  Behaviors.Bind = require("./bind")
  Behaviors.Vents = require("./vents")
  Marionette.Behaviors.behaviorsLookup = Behaviors

