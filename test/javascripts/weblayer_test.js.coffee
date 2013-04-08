#= require test_helper

suite 'Weblayer', ->

  test 'set namespaces for collections, models, routers, views', ->
    assert.ok Weblayer.Collections
    assert.ok Weblayer.Models
    assert.ok Weblayer.Routers
    assert.ok Weblayer.Views

  suite 'initialize()', ->
    setup ->
      @$header = $('<div id="app-controls-header">').appendTo('body')
      @$objects = $('<div id="app-controls-objects">').appendTo('body')
      @$views = $('<div id="app-controls-views">').appendTo('body')
      @$preview = $('<div id="app-preview">').appendTo('body')

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

      Weblayer.initialize({})

      callArg = spy.getCall(0).args[0]

      assert.ok spy.calledOnce
      assert.equal callArg.collection, Weblayer.devices
      assert.equal callArg.$iframe.get(0), @$preview.children('iframe').get(0)
      assert.lengthOf @$header.children(), 1

    test 'instantiates and renders a ComponentsIndex view', ->
      spy = sinon.spy(Weblayer.Views, 'ComponentsIndex')

      Weblayer.initialize({})

      assert.ok spy.calledWith(collection: Weblayer.components)
      assert.lengthOf @$views.children('.app-components'), 1

    test 'instantiates and renders the object views', ->
      spyIndex = sinon.spy(Weblayer.Views, 'ObjectsIndex')
      spyNew = sinon.spy(Weblayer.Views, 'ObjectsNew')

      Weblayer.initialize({})

      assert.ok spyIndex.calledWith(collection: Weblayer.objects)
      assert.ok spyNew.calledWith(collection: Weblayer.objects)
      assert.lengthOf @$objects.children('#app-objects-index'), 1
      assert.lengthOf @$objects.children('.app-objects-new'), 1

    test 'instantiates and renders a ContextMenu view', ->
      spy = sinon.spy(Weblayer.Views, 'ContextMenu')

      Weblayer.initialize({})

      callArg = spy.getCall(0).args[0]

      assert.isTrue callArg.$iframe.is(@$preview.children('iframe'))
      assert.lengthOf $('body').children('.context-menu'), 1
