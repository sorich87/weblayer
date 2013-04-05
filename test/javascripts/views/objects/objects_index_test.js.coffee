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

  test 'adds a new object to the view rendering', ->
    collection = new Weblayer.Collections.Objects
    view = new Weblayer.Views.ObjectsIndex(collection: collection)
    collection.add({title: 'Test Add'})

    assert.include view.$el.text(), 'Test Add'
    assert.ok view.$('.collapse').hasClass('in')
