#=require test_helper

suite 'Weblayer.Views.ComponentItem', ->

  test 'render() loads the component code', ->
    model = new Weblayer.Models.Component(title: 'Row')
    view = (new Weblayer.Views.ComponentItem(model: model)).render()

    assert.include view.$el.html(), 'Row'
    assert.ok view.$('a').data('tooltip')
