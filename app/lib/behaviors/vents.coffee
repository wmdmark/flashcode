module.exports = class VentsBehavior extends Marionette.Behavior

  """
  Auto binds App.vent listeners
  """

  defaults: {}

  onBeforeRender: ->
    for vent, handler of @options
      if _.isString(handler)
        handler = @view[handler]
      if _.isFunction handler
        @view.listenTo App.vent, vent, handler
      else
        throw new Error("Handler not found on view for vent \"#{vent}\"")
