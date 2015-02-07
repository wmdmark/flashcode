module.exports = class CardListItemView extends Marionette.ItemView
  template: require("./templates/card-list-item")
  className: "card-list-item-view"
  tagName: "li"

  behaviors:
    Bind:
      serializeBindData: ->
        model: @model
        state: @state

  initialize: ->
    @state = new Backbone.Model()

  modelEvents:
    "sync": "render"

  events:
    "click .edit, .item-link": -> App.execute("show:card:form", @model)
    "click .delete": -> @model.destroy()
    "click .view":  -> App.execute("show:card:view", @model, mode: "preview")
    "click .prompt-delete": -> @state.set("deleting", yes)
    "click .delete-cancel": -> @state.set("deleting", no)    