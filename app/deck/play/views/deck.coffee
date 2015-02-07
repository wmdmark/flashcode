CardView = require("card/play/views/card")
ScoreView = require("./score")
ScoreCard = require("./score-card")
ErrorCard = require("./error-card")

module.exports = class DeckView extends Marionette.LayoutView
  
  template: require("./templates/deck")
  className: "deck-view"

  ui:
    cards: "#cards-region"
    progress: ".progress"

  regions:
    scoreRegion: "#score-region"

  initialize: ->
    {@session} = @options
    @_cardIndex = 0

  onRender: ->
    $(window).on "resize", @_onResize
    if not @model.cards.length
      @model.cards.fetch()
        .then =>
          if @model.cards.length
            @start()
          else
            @showErrorCard("There are no cards in this deck.")
        .fail (err)->
          @showErrorCard(err.message)

  start: ->
    @nextCard()
    @scoreRegion.show(new ScoreView(model: @session, deck: @model))

  isAtEnd: ->
    @_cardIndex is (@model.cards.length - 1)

  nextCard: ->
    if @_cardIndex < @model.cards.length
      @showCard()
      @_cardIndex++
      @session.set("card_index", @_cardIndex)
    else
      @_showScoreCard()

  showCard: ->
    card = @model.cards.at(@_cardIndex)
    if @cardView
      @_transitionCardOut()
    
    @cardView = new CardView(model: card)
    @listenTo @cardView, "skip", @_onSkipCard
    @listenTo @cardView, "next", @nextCard
    @listenTo @cardView, "challenge:success", @_onCompleteCard
    @_transitionCardIn(@cardView)

  showErrorCard: (message)->
    errorCard = new ErrorCard(message: message)
    @_transitionCardIn(errorCard)

  _clearProgress: ->
    @ui.progress.html("")

  _updateProgress: (correct)->
    $bar = $('<div class="progress-bar" style="width: 0px"></div>')
    if correct
      $bar.addClass("progress-bar-success")
    else
      $bar.addClass("progress-bar-danger")
    @ui.progress.append($bar)
    w = 1 / @model.cards.length * 100
    $bar.velocity(width: "#{w}%", 200)

  _showScoreCard: ->
    @_transitionCardOut()
    @session.stopTimer()
    @cardView = new ScoreCard(model: @model, session: @session)
    @listenTo @cardView, "replay", @_onReplay
    @_transitionCardIn(@cardView)

  _onReplay: ->
    @_cardIndex = 0
    @_clearProgress()
    @session.reset()
    @nextCard()

  _onSkipCard: ->
    @session.addSkipped()
    @_updateProgress(false)
    @nextCard()

  _onCompleteCard: ->
    @session.addCompleted()
    @_updateProgress(true)

  _transitionCardIn: (view)->
    view.render()

    w = @$("#cards-region").width()
    view.$el.velocity({opacity: 0, left: w, top: 20}, 1)
    
    @ui.cards.append(view.el)
    view.triggerMethod("show")

    # transition in
    pos = @_getCardPosition(view)
    w = @$("#cards-region").width()
    transition =
      left: pos.x
      top: [pos.y, pos.y]
      opacity: 1

    $.Velocity.animate(view.$el, transition)
      .then => 
        view.triggerMethod("show")
        view.$el.addClass("transitioned-in")

  _getCardPosition: (view)->
    w = @$("#cards-region").width()
    cw = view.$el.width()
    x = (w / 2) - (cw / 2)
    return x: x, y: 40

  _transitionCardOut: ->
    _outView = @cardView
    w = _outView.$el.width()
    h = $("#app-primary-region").height()
    transition =
      left: -w
      #top: h
      opacity: 0
    $.Velocity.animate(_outView.el, transition)
      .then -> _outView.destroy()

  _onResize: =>
    if @cardView
      pos = @_getCardPosition(@cardView)
      @cardView.$el.velocity(left: pos.x, top: pos.y, 1)

  onDestroy: ->
    @cardView.destroy() if @cardView
    $(window).off "resize", @_onResize
