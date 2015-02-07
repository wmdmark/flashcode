Deck = require("deck/models/deck")

module.exports = class CreateDeckView extends require("lib/form/form")
  template: require("./templates/deck-form")
  className: "deck-form-view grid-form"

  initialize: ->
    @model ?= new Deck()

  onModalShown: ->
    @$(".deck-name").focus()

  onSubmit: ->
    @state.set("error", null)
    @setACL()
    @model.save()
      .then =>
        @triggerMethod "close:modal"
        #App.navigate("/deck/#{@model.id}/edit", trigger: yes)
      .fail (err)=>
        @state.set("error", err.message)

  setACL: ->
    acl = new Parse.ACL()
    acl.setWriteAccess(Parse.User.current(), true)
    acl.setRoleWriteAccess("Admin", true)
    acl.setPublicReadAccess(true)
    @model.setACL(acl)


