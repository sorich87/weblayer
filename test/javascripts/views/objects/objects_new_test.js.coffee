#= require test_helper

suite 'Weblayer.Views.ObjectsNew', ->

  setup ->
    @view = new Weblayer.Views.ObjectsNew().render()
    @view.collection = { add: sinon.spy() }
    @model = @view.model
    @model.save = sinon.spy()

  test 'save() persists its model', ->
    @view.$('input[name=title]').val('Test')
    @view.save($.Event())

    assert.ok @view.model.save.calledWith({}, success: @view.saved)
    assert.equal @view.model.get('title'), 'Test'

  test 'saved() adds the object to the collection', ->
    @view.saved($.Event())

    assert.ok @view.collection.add.calledWith(@model)

  test 'saved() resets its model', ->
    @view.model.set('title', 'Test Saved')
    @view.saved($.Event())

    assert.notEqual @view.model.get('title'), 'Test'

  test 'saved() re-renders the view', ->
    spy = sinon.spy(@view, 'render')
    @view.saved($.Event())

    assert.ok spy.calledOnce
