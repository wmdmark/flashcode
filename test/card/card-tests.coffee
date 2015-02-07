
assert = chai.assert

Card = require("card/models/card")
CardView = require("card/play/views/card")

describe "Card", ->

  region = new Marionette.Region(el: "#ui-tests")

  before ->
    require("initialize")

  it "should be able to render markdown", ->
    md = "Hi *Mark*!"
    expectedHTML = "<p>Hi <em>Mark</em>!</p>\n"
    assert.equal(marked(md), expectedHTML)    