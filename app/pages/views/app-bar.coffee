module.exports = class AppBarView extends Marionette.ItemView
  template: require("./templates/app-bar")
  tagName: "nav"
  className: "app-bar-view navbar navbar-default navbar-fixed-top"

  triggers:
    "click .navbar-brand": "show:home"
    "click .auth": "show:auth"
    "click .auth-out": "sign:out"
    "click .library": "show:library"
    "click .add-deck": "add:deck"
    "click .library-mine": "show:mine"

  behaviors:
    Vents:
      "session:unauthenticated": "render"
      "session:authenticated": "render"
      "navigate": "_setActiveState"


  onShowAuth: ->
    App.execute("show:auth:modal")

  onSignOut: ->
    App.execute("sign:out")

  onShowLibrary: ->
    App.navigate("/library", trigger: yes)

  onShowMine: ->
    App.navigate("/library/mine", trigger: yes)

  onAddDeck: ->
    App.execute("show:deck:form", deck)

  onShowHome: ->
    App.navigate("/", trigger: yes)

  _setActiveState: ->
    @.$(".nav > li").removeClass("active")
    route = App.getCurrentRoute()
    if route.indexOf("library") > -1
      @.$(".nav-library").addClass("active")

  serializeData: ->
    data = super()
    data.user = App.request("get:user")?.toJSON()
    data


