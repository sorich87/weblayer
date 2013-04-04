#= require test_helper

suite 'Views.ObjectItem', ->

  test 'renders an object', ->
    object = new Weblayer.Models.Object(title: 'Test')
    view = new Weblayer.Views.ObjectItem(model: object)
    assert.include view.render().$el.text(), 'Test'
