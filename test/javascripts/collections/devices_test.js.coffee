#= require test_helper

suite 'Weblayer.Collections.Devices', ->

  setup ->
    @collection = new Weblayer.Collections.Devices([
      {active: false, title: 'First'},
      {active: false},
      {active: false}
    ])

  test 'contains instances of Weblayer.Models.Device', ->
    assert.equal @collection.model, Weblayer.Models.Device

  test 'active() returns the first device if none is active', ->
    assert.equal @collection.active().get('title'), 'First'

  test 'active() return the active device', ->
    @collection.add(active: true, title: 'Active')
    assert.equal @collection.active().get('title'), 'Active'

  test 'ensures only one device is active', ->
    @collection.add(active: true)
    @collection.add(active: true)
    assert.lengthOf @collection.where(active: true), 1
