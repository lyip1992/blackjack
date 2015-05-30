class window.BetView extends Backbone.View
  className: 'bet'

  template: _.template '<div></div>'

  initialize: -> @render()

  render: ->
    @$el.html @template

