class Weblayer.Models.Component extends Backbone.Model

  defaults:
    title: ''
    description: ''
    html: ''
    default: false

  initialize: ->
    @on('change', @setDefaultsHTML)
    @setDefaultsHTML()

  setDefaultsHTML: =>
    if @.get('default') && !@.get('html')
      file = @.get('title').toLowerCase().replace(' ','-')
      @set('html', JST['components/defaults/' + file]())
