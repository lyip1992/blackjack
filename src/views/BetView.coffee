class window.BetView extends Backbone.View
  className: 'bet'

  template: _.template '<div> \
                          <input type="text" name="bet-text" value="" placeholder="0"> \
                          <button type="button" id="betButton">Place Bet</button> \
                          <button type="button" id="plusBet">+ $10</button> \
                          <button type="button" id="minusBet">- $10</button> \
                          <div class="playerMoney"> Bet: $<%- pbet %> </div> \
                          <div class="playerMoney"> Cash: $<%- pmoney %> </div> \
                        </div>'

  events: {
    'click #betButton': 'handleBet',
    'click #plusBet': 'increaseBet',
    'click #minusBet': 'decreaseBet'
  },

  handleBet: ->
    #parse the bet value from textbox
    bet = ( if @$('input').val() == "" then 0 else parseInt(@$('input').val()) )
    console.log("handleBet: bet: #{bet}")
    #reset the bet textbox
    @$('input').val('')
    #remove bet amount from player (hand)
    console.log("handleBet: pmoney: #{@collection.money}")
    @collection.money -= bet
    #update hand current bet
    @collection.currentBet += bet
    #re-render so money after bet displays
    @$('input').val('')
    @render()

  increaseBet: ->
    currentInput = ( if @$('input').val() == "" then 0 else parseInt(@$('input').val()) )
    currentInput = parseInt(currentInput)
    currentInput += 10
    currentInput = Math.min(currentInput, @collection.money)
    @$('input').val(currentInput)

  decreaseBet: ->
    currentInput = ( if @$('input').val() == "" then 0 else parseInt(@$('input').val()) )
    currentInput = parseInt(currentInput)
    currentInput -= 10
    currentInput = Math.max(currentInput, 0)
    @$('input').val(currentInput)

  initialize: -> @render()

  render: ->
    @$el.html @template {pbet : @collection.currentBet , pmoney : @collection.money}

