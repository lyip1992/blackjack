class window.BetView extends Backbone.View
  className: 'bet'

  template: _.template '<div> \
                          <input type="text" name="bet-text" value="" placeholder="0"> \
                          <button type="button" id="betButton">Place Bet</button> \
                          <button type="button" id="plusBet">+ $10</button> \
                          <button type="button" id="minusBet">- $10</button> \
                          <div class="playerMoney"> $<%- pmoney %> </div>
                        </div>'

  events: {
    'click #betButton': 'handleBet',
    'click #plusBet': 'increaseBet',
    'click #minusBet': 'decreaseBet'
  },

  handleBet: ->
    #parse the bet value from textbox
    bet = parseInt(@$('input').val())
    #reset the bet textbox
    @$('input').val('')
    #remove bet amount from player (hand)
    @collection.money -= bet
    #update hand current bet
    @collection.currentBet = bet
    #re-render so money after bet displays
    @render()

  increaseBet: ->
    @collection.currentBet += 10
    @$('input').val(@collection.currentBet)

  decreaseBet: ->
    cbet = parseInt(@$('input').val())
    if cbet <= 10
      cbet = 0
    else
      cbet -= 10
    @collection.currentBet = cbet
    @$('input').val(cbet)

  initialize: -> @render()

  render: ->
    @$el.html @template {pmoney : @collection.money}

