module.exports = class SignUpInView extends require("lib/form/form")
  template: require("./templates/sign-up-in")
  className: "sign-up-in-view grid-form"

  initialize: ->
    @model ?= new Backbone.Model()

  onModalShown: ->
    @$("input[type='email']").focus()

  onSubmit: ->
    @state.set("error", null)
    data =  @model.attributes
    App.request("guarantee:user", data.email, data.password)
      .then (user)=>
        @triggerMethod("close:modal")
        @triggerMethod("authenticated")
      .fail (err)=>
        # Failed login attempt
        if err.code is 101
          @state.set("error", "Invalid email or password.")
        else
          @state.set("error", err.message)

        