module.exports = class DeckThumbView extends Marionette.ItemView
  template: require("./templates/deck-thumb")

  className: "deck-thumb-view col-xs-6 col-sm-4 col-md-3 col-lg-3"

  modelEvents:
    "sync": "render"

  triggers:
    "click .play-deck, .thumb-link": "play:deck"
    "click .edit-deck": "edit:deck"

  events:
    "click .delete": -> @model.destroy()
    "click .prompt-delete": -> @state.set("deleting", yes)
    "click .delete-cancel": -> @state.set("deleting", no)    

  behaviors:
    Bind:
      serializeBindData: ->
        model: @model
        state: @state

  initialize: ->
    @state = new Backbone.Model()

  onEditDeck: ->
    App.navigate("/deck/#{@model.id}/edit", trigger: yes)

  onPlayDeck: ->
    App.navigate("/deck/#{@model.id}/play", trigger: yes)

  serializeData: ->
    data = super()
    user = App.request("get:user")
    if data.owner? and user?
      data.show_admin = data.owner?.objectId is user.id
    data