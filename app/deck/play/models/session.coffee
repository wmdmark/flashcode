module.exports = class Session extends Backbone.Model

  defaults: ->
    skipped: 0
    completed: 0
    card_index: 0
    timer: 0
    timer_formatted: "00:00"

  initialize: ->
    @startTimer()

  startTimer: ->
    tick = =>
      @set("timer", @get("timer") + 1)
      @set("timer_formatted", moment(@get("timer") * 1000).format("mm:ss"))
    @_timer = setInterval tick, 1000

  reset: ->
    @set(@defaults())
    @startTimer()

  stopTimer: ->
    clearInterval @_timer

  addSkipped: ->
    @set("skipped", @get("skipped") + 1)

  addCompleted: ->
    @set("completed", @get("completed") + 1)  