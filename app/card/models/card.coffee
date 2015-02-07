module.exports = class Card extends Parse.Object
  className: "Card"
  idAttribute: "objectId"
  
  defaults: ->
    context: ""
    type: "JS"
    instructions: ""
    initial: ""
    solution: ""
    validation: ""

  initialize:->
    sandboxTemplate = require("card/play/views/templates/sandbox")
    @sandbox = new Sandbox
      html: sandboxTemplate()

  getInstructionsRendered: ->
    marked(@get("instructions"))

  setRenderedMarkdown: ->
    @set("instructions_rendered", @getInstructionsRendered())

  checkData: ->
    data = @attributes

    if not data.instructions
      return "Please enter instructions."
    if not data.validation
      return "Please enter JavaScript validation."

    return

  runSolution: (solution)->
    d = new $.Deferred()
    
    code = [
      @get("context"),
      solution
      @get("validation")
    ].join("\n")

    #console.log "running solution: ", code

    try
      @sandbox.evaluate(code)
      d.resolve(@)
    catch e
      switch e.name
        when "SyntaxError"
          d.reject(new Error("Invalid JavaScript: #{e.message}"))
        else
          d.reject(new Error("Error: #{e.message}"))

    d.promise()
