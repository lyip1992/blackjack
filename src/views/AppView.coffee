class window.AppView extends Backbone.View
  # Controller code ###

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @listenTo @model.get('playerHand'), 'busted', @startNewGame

  startNewGame: ->
    @model.playerLost()
    @model.initialize()
    @listenTo @model.get('playerHand'), 'busted', @startNewGame
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

