class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img class="cardIMG" src="img/cards/<%= rankName %>-<%= suitName.toLowerCase() %>.png">'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

