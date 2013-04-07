#= require test_helper

suite 'Weblayer.Models.Component', ->

  test 'initialize() sets the html', ->
    component = new Weblayer.Models.Component(Weblayer.Defaults.components[0])

    assert.notEqual component.get('html'), ''
