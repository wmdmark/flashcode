module.exports = (options)->
  require("config/initialize")
  App = require("./app")
  window.App = App
  App.start(options)