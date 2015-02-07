module.exports = class SandboxView extends Marionette.ItemView
  
  template: require("./templates/sandbox")
  className: "sandbox-view"

  triggers:
    "click #evaluate-code": "play:sandbox"

  initialize: ->
    @createSandbox()

  createSandbox: ->
    @sandbox = new Sandbox
      html:
        "<script src='//cdnjs.cloudflare.com/ajax/libs/chai/1.10.0/chai.js'></script>
        <script>
          window.assert = chai.assert
        </script>"

  onPlaySandbox: ->
    code = document.getElementById('code').value
    try
      result = @sandbox.evaluate code
      @triggerMethod "sandbox:result",
        result: "correct"
    catch e
      console.log "the error", e
      @triggerMethod "sandbox:result",
        result: "wrong"
        error: e

