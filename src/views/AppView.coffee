class window.AppView extends Backbone.View
  # Controller code ###
  el: '<div class="main"></div>'

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @listenTo @model.get('playerHand'), 'busted', @gameOver
    @listenTo @model.get('playerHand'), 'stand', @dealerTurn

  dealerTurn: ->
    @listenTo @model.get('dealerHand'), 'busted', @gameOver
    @listenTo @model.get('dealerHand'), 'stand', @checkWinner
    @model.get('dealerHand').hitUntil(17)

  checkWinner: ->
    pScore = @model.get('playerHand').bestScore()
    dScore = @model.get('dealerHand').bestScore()

    if pScore > dScore then alert "Player wins!"
    else if pScore < dScore then alert "Dealer wins!"
    else alert "Draw!"

    @startNewGame()

  gameOver: (winnerHand) ->
    alert "Busted!"
    @startNewGame()

  startNewGame: ->
    @model.initialize()

    # re-attach event listeners
    @listenTo @model.get('playerHand'), 'busted', @gameOver
    @listenTo @model.get('playerHand'), 'stand', @dealerTurn
    @render()

  # View code ###
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '



  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

