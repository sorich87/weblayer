#= require test_helper

suite 'Views.ObjectItem', ->

  setup ->
    object = new Weblayer.Models.Object
      title: 'Test'
      fields: [{name: 'Field One', type: 'time'}]
    @view = new Weblayer.Views.ObjectItem(model: object).render()
    @view.model.save = sinon.spy()

  test 'renders an object', ->
    assert.include @view.$el.text(), 'Test'
    assert.lengthOf @view.$('input[value="Field One"]'), 1

  test 'addField() add new fields', ->
    @view.addField()

    assert.lengthOf @view.model.fields, 2

  test "save() saves the object when it's fields change", ->
    @view.model.fields.first().set({name: 'Field Two', type: 'string'})
    assert.ok @view.model.save.calledOnce
