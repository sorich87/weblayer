#= require test_helper

suite 'Weblayer.Views.ObjectField', ->

  setup ->
    field = new Weblayer.Models.ObjectField(name: 'Field One', type: 'time')
    @view = new Weblayer.Views.ObjectField(model: field).render()

  test 'renders an object field', ->
    assert.lengthOf @view.$('input[value="Field One"]'), 1
    assert.include @view.$el.html(), '<option selected="selected">time</option>'

  test 'edit() changes the field attributes values', ->
    @view.$('input').val('New Name').trigger('change')
    @view.$('select').val('datetime').trigger('change')

    assert.equal @view.model.get('name'), 'New Name'
    assert.equal @view.model.get('type'), 'datetime'

  test 'remove() cleans up the view', ->
    @view.model.destroy = sinon.spy()
    @view.$el.remove = sinon.spy()
    @view.off = sinon.spy()
    @view.remove()

    assert.ok @view.model.destroy.calledOnce
    assert.ok @view.$el.remove.calledOnce
    assert.ok @view.off.calledOnce
