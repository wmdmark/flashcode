should = chai.should()
assert = chai.assert

# CardView = require("card/admin/views/create-card")
# Card = require("card/admin/models/card")

# describe "Create Card", ->

#   it "should do awesome", (done)->

#     card = new Card
#       type: "JS"
#       instructions: "Define a variable `x` equal to 10.",
#       initial: "var x = ",
#       solution: "var x = 10;",
#       validation: "
#         assert(x, 'x variable is undefined');\n
#         assert(x == 10, 'x variable does not equal 10');\n
#       "
#     cardView = new CardView(model: card)
#     $("#ui-tests").append cardView.render().el