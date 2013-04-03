class Weblayer.Views.DevicesIndex extends Backbone.View

  tagName: 'ul'
  className: 'devices'

  subViews: {}

  initialize: ->
    @collection.on('change:active', @resizeIframe)

  render: =>
    @collection.each (device) =>
      (new Weblayer.Views.DeviceItem(model: device)).render().$el
        .appendTo(@$el)
    width = @collection.active().get('width')
    @options.$iframe.animate(width: '100%')
    @

  resizeIframe: (changed) =>
    if changed.get('active') == true
      width = changed.get('width')
      @options.$iframe.animate(width: width)
