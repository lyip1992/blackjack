class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: (money) ->
    if !money
      money = 100
    new Hand [@pop(), @pop()], @, false, "Leon", money

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true, "DealerGuy", 0

