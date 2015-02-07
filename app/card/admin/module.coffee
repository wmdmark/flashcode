CardForm = require("./views/card-form")
CardPlayView = require("card/play/views/card")

module.exports = App.module "CardAdminModule", (Global, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  App.commands.setHandler "show:card:form", (card, options={})->
    options.model = card
    App.modal.show(new CardForm(options))

  App.commands.setHandler "show:card:view", (card, options={})->
    options.model = card
    App.modal.show(new CardPlayView(options))