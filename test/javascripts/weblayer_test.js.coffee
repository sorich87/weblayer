#= require test_helper

suite 'Weblayer', ->

  test 'set namespaces for collections, models, routers, views', ->
    assert.ok Weblayer.Collections
    assert.ok Weblayer.Models
    assert.ok Weblayer.Routers
    assert.ok Weblayer.Views

  suite 'initialize()', ->
    test 'instantiates objects from data', ->
      data =
        objects: [
          {title: 'One', fields: []},
          {title: 'Two', fields: []}
        ]
      Weblayer.initialize(data)

      assert.isDefined Weblayer.objects
      assert.equal Weblayer.objects.length, 2
      assert.equal Weblayer.objects.models[1].get('title'), 'Two'

    test 'instantiates and renders a DevicesIndex view', ->
      spy = sinon.spy(Weblayer.Views, 'DevicesIndex')
      $div = $('<div id="app-controls-header">').appendTo('body')

      Weblayer.initialize({})

      attributes =
        collection: Weblayer.devices
        $iframe: $('#app-preview iframe')

      assert.ok spy.calledWith(attributes)
      assert.lengthOf $div.children(), 1

    test 'instantiates and renders the object views', ->
      spyIndex = sinon.spy(Weblayer.Views, 'ObjectsIndex')
      spyNew = sinon.spy(Weblayer.Views, 'ObjectsNew')
      $div = $('<div id="app-controls-objects">').appendTo('body')

      Weblayer.initialize({})

      assert.ok spyIndex.calledWith(collection: Weblayer.objects)
      assert.ok spyNew.calledWith(collection: Weblayer.objects)
      assert.lengthOf $div.children('#app-objects-index'), 1
      assert.lengthOf $div.children('.app-objects-new'), 1
