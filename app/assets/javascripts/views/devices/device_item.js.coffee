class Weblayer.Views.DeviceItem extends Backbone.View

  tagName: 'li'

  template: JST['devices/item']

  events:
    "click a": "activate"

  initialize: ->
    @model.on 'all', @toggleActive

  render: =>
    @$el.html(@template(device: @model))
    @$el.addClass('active') if @model.get('active')
    @

  activate: (e) =>
    e.preventDefault()
    @model.set('active', true)

  toggleActive: (event, model) =>
    @$el.toggleClass('active', model.get('active') == true)
