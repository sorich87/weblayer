#= require test_helper

suite 'Views.ObjectsIndex', ->

  setup ->

  test 'renders the objects', ->
    collection = new Weblayer.Collections.Objects([
      {title: 'Test One'}, {title: 'Test Two'}
    ])
    view = new Weblayer.Views.ObjectsIndex(collection: collection)

    accordions = view.render().$('.accordion-heading')
    assert.lengthOf accordions, view.collection.length

  test 'renders the objects on add, remove or reset', ->
    spy = sinon.spy(Weblayer.Views.ObjectsIndex.prototype, 'render')

    collection = new Weblayer.Collections.Objects
    view = new Weblayer.Views.ObjectsIndex(collection: collection)

    view.collection.trigger('add')
    assert.ok spy.calledOnce

    view.collection.trigger('remove')
    assert.ok spy.calledTwice

    view.collection.trigger('reset')
    assert.ok spy.calledThrice

    Weblayer.Views.ObjectsIndex.prototype.render.restore()
