should = chai.should()

describe "Application", ->

  before ->
    require("initialize")

  it "creates a global app variable", ->
    should.exist(App)