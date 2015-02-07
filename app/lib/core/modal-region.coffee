module.exports = class ModalRegion extends Marionette.Region
  
  onShow: (view)->
    @listenTo view, "close:modal", @closeModal
    view.$el.addClass("modal-view")

    @.$el.on "shown.bs.modal", ->
      view.triggerMethod("modal:shown")
    @.$el.on "hidden.bs.modal", @closeModal
    
    @.$el.modal
      backdrop: yes
      keyboard: yes
    
    @.$el.modal("show")
    
  closeModal: =>
    @.$el.modal("hide")
    if @currentView
      @currentView.triggerMethod("modal:closed")
    @reset()
    @_ensureElement()