class window.Hand extends Backbone.Collection
  model: Card,

  bustStatus: false,

  playerName: "player",

  initialize: (array, @deck, @isDealer, name) ->
    @playerName = name

  hit: ->
    @add(@deck.pop())
    @isBust()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  isBust: ->
    if @minScore() > 21
      @bustStatus = true
      console.log "busted!"
      @trigger 'busted', "#{@playerName} busted!"


    # this will check minScore and see if it is over 21
    # if it is, then tringger busted (app.coffee will listen for the busted event)

  bestScore: ->
    #TODO: this is not complete
    console.log 'best score output'
    console.log @scores()[0]
    @scores()[0]


  stand: ->
    # capture the current score
    console.log "stand triggered"
    @trigger 'stand', this

  hitUntil: (score) ->
    @first().flip()
    console.log "delaer is playing"
    while @bestScore() < score
      @hit()
    @stand() unless @bustStatus
    return


    # transfer control to the dealer and have him start playing
