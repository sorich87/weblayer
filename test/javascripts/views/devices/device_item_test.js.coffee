#= require test_helper

suite 'Views.DeviceItem', ->

  setup ->
    device = new Weblayer.Models.Device

    @view = new Weblayer.Views.DeviceItem(model: device)

  test 'renders a device', ->
    assert.lengthOf @view.render().$('a'), 1

  test 'has active class for an active device', ->
    @view.model.set('active', true)
    assert.isTrue @view.render().$el.hasClass('active')

    @view.model.set('active', false)
    assert.isFalse @view.render().$el.hasClass('active')

  test 'adds active class when the device is activated', ->
    @view.render()

    @view.model.set('active', true)
    assert.isTrue @view.$el.hasClass('active')

    @view.model.set('active', false)
    assert.isFalse @view.$el.hasClass('active')

  test 'activate() activates the device', ->
    @view.render().activate(new $.Event)
    assert.isTrue @view.model.get('active')
