CardView = require("card/play/views/card")
Card = require("card/models/card")

module.exports = class HomeView extends Marionette.LayoutView
  template: require("./templates/home")
  className: "home-view"

  regions:
    preview: "#preview-card-region"

  events:
    "click .deck-link": "onClickDeck"
    "click .a-deck": "onPlayDeck"

  onShow: ->
    data =
      name: "Flashcode"
      instructions: "Can you `JavaScript?`"
      initial: "var answer = // ?"
      validation: "assert.equal(answer, true);"
    card = new Card(data)
    cardView = new CardView(model: card, mode: "preview")
    @listenTo cardView, "next", ->
      App.navigate("/library", trigger: yes)
    @preview.show(cardView)
    cardView.$el.velocity("transition.slideRightBigIn")
    

  onClickDeck: (e)->
    e.preventDefault()
    App.navigate($(e.currentTarget).attr("href"), trigger: yes)

  onPlayDeck: (e)->
    id = $(e.currentTarget).attr("data-id")
    App.navigate("deck/#{id}/play", trigger: yes)