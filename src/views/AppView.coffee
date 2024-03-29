class window.AppView extends Backbone.View
  # Controller code ###
  el: '<div></div>'

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @listenTo @model.get('playerHand'), 'busted', @referee
    @listenTo @model.get('playerHand'), 'stand', @dealerTurn

  dealerTurn: ->
    @listenTo @model.get('dealerHand'), 'busted', @referee
    @listenTo @model.get('dealerHand'), 'stand', @referee
    @model.get('dealerHand').hitUntil(17)

  checkWinner: (player, dealer) ->
    pScore = player.bestScore()
    dScore = dealer.bestScore()

    if pScore > dScore then return 1
    else if pScore < dScore then return -1
    else return 0

  referee: (caller) ->
    console.log "referee is on it!"
    player = @model.get('playerHand')
    dealer = @model.get('dealerHand')
    #if player is busted
    if player.bustStatus
      console.log "referee: player is busted"
      @logthis "Player lost! Player busted!"
    #if dealer gets busted
    else if dealer.bustStatus
      player.money += player.currentBet * 2
      console.log "referee: dealer is busted"
      @logthis "Player wins! Dealer busted!"
    #if all stands
    else
      #check winner
      winner = @checkWinner(player, dealer)
      if winner == 0
        # return the betted amount back to the player
        player.money += player.currentBet
        console.log("referee: draw!")
        @logthis "Draw!"
      if winner == 1
        # we want to double the bet and add it back to the player
        player.money += player.currentBet * 2
        console.log("referee: player wins!")
        @logthis "Player wins!"
      if winner == -1
        console.log("referee: player lost, dealer wins!")
        @logthis "Player lost, Dealer wins!"

    player.currentBet = 0
    console.log("referee: starting new game!")
    #@logthis "referee: starting new game!"
    @startNewGame()

  startNewGame: ->
    @model.nextRound()

    # re-attach event listeners
    @listenTo @model.get('playerHand'), 'busted', @referee
    @listenTo @model.get('playerHand'), 'stand', @dealerTurn
    @render()

  logthis: (message) ->
    console.log("trying to log #{message}")
    console.log(@$('.logdiv').html())
    @$('.logdiv').prepend(">>#{message}<br>")
    console.log(@$('.logdiv').html())

  # View code ###
  template: _.template '
    <div class="main">
      <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
      <div class="dealer-hand-container"></div>
      <div class="player-hand-container"></div>
    </div>
    <div class="logdiv"><div class="fader"></div></div>
    '

  render: ->
    msgs = @$('.logdiv').html()
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.logdiv').html(msgs)

