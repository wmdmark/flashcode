should = chai.should()
assert = chai.assert
SandboxView = require("sandbox/views/sandbox")

describe "Sanbox", ->

  it "should do awesome", (done)->
    sandboxView = new SandboxView()
    $("#ui-tests").append sandboxView.render().el

    tests = [
      {
        code: "
          var x = 2
        "
        validation: "
          assert(x === 2, 'x is 2');
        "
        assert: "correct"
      }, {
        code: "
          var x = 3
        "
        validation: "
          assert(x === 2, 'x is 2');
        "
        assert: "wrong"
      }, {
        code: "
          function fn (x) { return x*x }
        "
        validation: "
          assert(fn(2) === 4, 'fn(2) is 4');
          assert(fn(3) === 9, 'fn(3) is 9');
        "
        assert: "correct"
      }
    ]

    i = 0
    sandboxView.on "sandbox:result", (res)->
      assert(res.result is tests[i].assert)
      i++
      done() if i is tests.length

    _.defer ->
      for test in tests
        $("#code").val test.code + ";" + test.validation
        $("#evaluate-code").click()
