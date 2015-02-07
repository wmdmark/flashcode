module.exports = class CardFormView extends require("lib/form/form")
  
  template: require("./templates/card-form")
  className: "card-form-view grid-form"

  ui:
    editors: ".ace-editor"

  onModalShown: ->
    @$(".card-name").focus()
    
  onSubmit: ->
    @model.set
      instructions: @getEditorVal("ace-editor-instructions")
      context: @getEditorVal("ace-editor-context")
      initial: @getEditorVal("ace-editor-initial")
      validation: @getEditorVal("ace-editor-validation")
    @model.setRenderedMarkdown()

    error = @model.checkData()
    if not error
      @state.set("error", null)
      @setACL()
      @model.save()
        .then (card)=>
          @triggerMethod("card:saved", card)
          @triggerMethod("close:modal")
        .fail (err)=>
          @state.set("error", err.message)
    else
      @state.set("error", error)

  setACL: ->
    acl = new Parse.ACL()
    acl.setWriteAccess(Parse.User.current(), true)
    acl.setRoleWriteAccess("Admin", true)
    acl.setPublicReadAccess(true)
    @model.setACL(acl)
