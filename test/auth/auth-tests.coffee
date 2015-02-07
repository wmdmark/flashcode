should = chai.should()
assert = chai.assert

User = require("auth/models/user")

describe "Auth", ->

  user = null

  before ->
    require("initialize")

  after (done)->
    user.destroy().then -> done()

  it "can signup a user", (done)->
    user = new User
      username: "mofo"
      password: "password"
    user.signUp()
      .then (user)->
        assert.ok(user.id)
        done()
      .fail (err)-> throw new Error(err.message)





