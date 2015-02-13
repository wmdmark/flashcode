module.exports = class CardView extends require("lib/form/form")
  
  template: require("./templates/card")
  className: "card-view"

  triggers:
    "click .btn-submit-solution": "submit:solution"
    "click .skip": "skip"
    "click .next": "next"

  ui:
    instructions: ".instructions"

  behaviors:
    Bind:
      serializeBindData: ->
        model: @model
        state: @state

  initialize: ->
    @state = new Backbone.Model
      message: null
      error: no
      completed: no

  serializeData: ->
    data = super()
    #data.instructions_doc = @getInstructionsDoc()
    if @options.mode
      data.mode = @options.mode
    data

  getInstructionsDoc: ->
    instructions = @model.get("instructions_rendered")
    if not instructions
      instructions = @model.getInstructionsRendered()
    template = require("./templates/instructions-sandbox")
    doc = template(content: instructions)
    doc

  onRender: ->
    @.$el.addClass(@options.mode)

  onShow: ->
    $iframe = @.$("iframe")
    @listenToOnce App.vent, "sandbox:loaded", ->
      height = $iframe.contents().height()
      $iframe.height(height)
    $iframe.attr("srcdoc", @getInstructionsDoc())

  onSubmitSolution: ->
    @state.set(message: null)
    @model.runSolution(@getEditorVal("solution-editor"))
      .then =>
        @state.set
          message: "Good job!"
          error: no
        state = @options.state
        if state? is "preview"
          console.log "it worked"
        else
          @state.set("completed", yes)
        @triggerMethod("challenge:success")
      .fail (err)=>
        @triggerMethod("challenge:fail", err)
        @state.set
          message: err.message
          error: yes