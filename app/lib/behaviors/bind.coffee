module.exports = class BindBehavior extends Marionette.Behavior

  defaults:
    init: null
    bindEvent: "render"
    serializeBindData: ->
      model: @model
    getBindEl: -> @el

  initialize: ->
    
    if _.isFunction @options.init
      _.bind(@options.init, @view)()
    
    if @options.bindEvent
      @listenTo @view, @options.bindEvent, @_bind
    
    @listenTo @view, "apply:binding", @_bind
    
  _bind: ->
    @binding.unbind() if @binding?
    @view.triggerMethod("before:bind")
    bindData = _.bind(@options.serializeBindData, @view)
    el = _.bind(@options.getBindEl, @)()
    @binding = rivets.bind(el, bindData())
    @view.triggerMethod("bind")

  onDestroy: ->
    @binding?.unbind()