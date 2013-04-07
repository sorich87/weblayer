#= require test_helper

suite 'Views.DevicesIndex', ->

  setup ->
    @view = new Weblayer.Views.DevicesIndex
      collection: new Weblayer.Collections.Devices(Weblayer.Defaults.devices)
      $iframe: $('<div id="#app-preview iframe">')

  test 'renders the devices', ->
    assert.lengthOf @view.render().$('li'), Weblayer.Defaults.devices.length

  test 'resizes the iframe when active device changes', ->
    $.fx.off = true
    @device = @view.collection.findWhere(active: false)

    assert.notEqual @view.options.$iframe.css('width'), @device.get('width')

    @device.set(active: true)
    assert.equal @view.options.$iframe.css('width'), @device.get('width')
