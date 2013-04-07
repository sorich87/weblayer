#= require test_helper

suite 'Weblayer.Views.ComponentsIndex', ->

  test 'renders the components views', ->
    components = Weblayer.Defaults.components
    collection = new Weblayer.Collections.Components(components)
    view = new Weblayer.Views.ComponentsIndex(collection: collection).render()

    assert.lengthOf view.$('li'), components.length
