module.exports = 
  decks: [
    {
      name: "Test Deck"
      cards: [
        {
          instructions: "Define a variable `x` equal to 10.",
          initial: "var x = ",
          solution: "var x = 10;",
          validation: "
            assert(x, 'x variable does not exist')
            assert(x == 10, 'x variable does not equal 10');
          "
        }
    ]
    }
  ]
