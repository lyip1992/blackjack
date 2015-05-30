# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  nextRound: ->
    pmoney = @get('playerHand').money
    console.log("app: nextRond: pmoney: #{pmoney}")
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer(pmoney)
    @set 'dealerHand', deck.dealDealer()
