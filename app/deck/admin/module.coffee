Deck = require("deck/models/deck")
DeckForm = require("./views/deck-form")
DeckEditView = require("./views/deck-edit")

module.exports = App.module "DeckAdminModule", (Global, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class Global.Router extends Marionette.AppRouter
    appRoutes:
      "deck/add": "add"
      "deck/:id/edit": "edit"

  checkPermission = (deck=null)->
    user = App.request("get:user")
    hasPerms = user?
    if hasPerms and deck?
      hasPerms = deck.owner is user.id
    if not hasPerms
      App.execute("show:auth:modal", next=App.getCurrentRoute())
    hasPerms

  API =
    add: ->
      if checkPermission()
        deck = new Deck(owner: App.request("get:user"))
        App.execute("show:deck:form", deck)
    edit: (id)->
      if checkPermission()
        deck = new Deck(id: id)
        deck.fetch()
          .then (deck)->
            App.primary.show(new DeckEditView(model: deck))
          .fail (err)->
            alert("Failed to load deck: #{err.message} (#{err.code}")

  App.commands.setHandler "show:deck:form", (deck)->
    App.modal.show(new DeckForm(model: deck))

  App.addInitializer ->
    new Global.Router controller: API
    # setup the app bar