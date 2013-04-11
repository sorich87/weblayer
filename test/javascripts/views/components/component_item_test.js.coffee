#=require test_helper

suite 'Weblayer.Views.ComponentItem', ->

  setup ->
    model = new Weblayer.Models.Component(title: 'Row', 'html': 'some html')
    @view = (new Weblayer.Views.ComponentItem(model: model)).render()
    @spy = sinon.spy(Backbone, 'trigger')

  teardown ->
    Backbone.trigger.restore()

  suite 'render()', ->

    test 'loads the component code', ->
      assert.include @view.$el.html(), 'Row'
      assert.ok @view.$('a').data('tooltip')

  suite 'dragStart()', ->
    setup ->
      o = {dataTransfer: {setData: ->}}
      @e = $.Event('dragstart', originalEvent: o)

    test 'triggers drag:start event', ->
      @view.dragStart(@e)

      assert.ok @spy.calledWith('drag:start')
      assert.instanceOf @spy.args[0][1], $

    test 'hides the tooltip', ->
      spy = sinon.spy(@view.$('a').constructor.prototype, 'tooltip')
      @view.dragStart(@e)

      assert.ok spy.calledWith('hide')

  suite 'dragEnd()', ->
    test 'triggers drag:end event', ->
      @view.dragEnd()

      assert.ok @spy.calledWith('drag:end')
