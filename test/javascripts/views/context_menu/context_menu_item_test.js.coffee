#=require test_helper

suite 'Weblayer.Views.ContextMenuItem', ->

  test 'renders the menu item', ->
    model = new Weblayer.Models.ContextMenuItem(name: 'cut')
    view = (new Weblayer.Views.ContextMenuItem(model: model)).render()

    assert.include view.$('a').text(), 'cut'
    assert.isTrue view.$el.hasClass('cut')
