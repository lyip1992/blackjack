class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2>
                          <% if(isDealer){ %>
                            Dealer
                          <% }else{ %>
                            You
                          <% } %>
                          (<span class="score"></span>)
                        </h2>
                        <% if(!isDealer) {%>
                          <div class="bet-container">
                          </div>
                        <% } %>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @collection.forEach ((card) ->
      @$el.append(new CardView(model: card).$el).fadeIn(1000)
    ), this
    @$('.score').text(@collection.scores()[0])
    @$('.bet-container').html new BetView(collection: @collection).el

