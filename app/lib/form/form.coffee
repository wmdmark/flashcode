module.exports = class Form extends Marionette.ItemView
  
  tagName: "form"

  constructor: ->
    @state = new Backbone.Model(valid: no)
    super(arguments...)
    @on "render", @initForm
    @on "show", @initWidgets
  
  initForm: ->
    @listenTo @state, "change:valid", ->
      @triggerMethod("validation:state:changed", @state.get("valid"))

    @triggerMethod("before:init:form")
    @initValidation()
    @triggerMethod("after:init:form")
    @bind()


  bind: ->
    @binding = rivets.bind(@el, @getBindData())

  getBindData: ->
    model: @model
    state: @state

  initWidgets: ->
    @initEditors()

  initEditors: ->
    if @.$(".ace-editor").length
      modes =
        "js": ace.require("ace/mode/javascript").Mode
        "md": ace.require("ace/mode/markdown").Mode
      
      @_editors = {}
      @.$(".ace-editor").each (i, el)=>
        elID = $(el).attr("id")
        code = @model.get($(el).data("field"))
        editor = ace.edit(elID)
        editor.setAutoScrollEditorIntoView(yes)
        editor.$blockScrolling = Infinity
        editor.setOption("maxLines", 30)
        editor.setOption("minLines", 8)
        
        editor.setValue(code)
        editor.clearSelection()
        
        @_editors[elID] = editor
        $(el).data("editor", editor)
        Mode = modes[$(el).data("mode")]
        editor.getSession().setMode(new Mode())
        editor.setTheme("ace/theme/twilight")

  onDestroy: ->
    if @_editors
      for key, editor of @_editors
        editor.destroy()

  getEditor: (id)->
    @_editors[id]
    
  getEditorVal: (id)->
    @_editors[id]?.getValue()

  setFocus: ->
    _.defer => 
      $f = @_getFirstEmptyField()
      $f.focus()

  _getFirstEmptyField: ->
    @.$("input[value='']:not(:checkbox,:button):first")

  initValidation: ->
    @pform = @.$el.parsley()
    $.listen "parsley:field:validated", @, (pfield)->
      pform = pfield.parent
      @state.set("valid", pform.isValid())
    
    @.$el.on "submit", (e)=>
      e.preventDefault()
      @triggerMethod("submit")

  validate: ->
    @state.set("valid", @pform.isValid())

  onBeforeClose: ->
    @off "render", @initForm
    @.$el.parsley('destroy')    

