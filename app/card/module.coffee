module.exports = App.module "CardModule", (Global, App, Backbone, Marionette, $, _) ->
  @startWithParent = false
  require("./play/module").start()
  require("./admin/module").start()