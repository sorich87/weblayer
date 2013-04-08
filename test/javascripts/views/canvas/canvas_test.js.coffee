#= require test_helper

suite 'Weblayer.Views.Canvas', ->

  setup ->
    @view = new Weblayer.Views.Canvas()
    @view.$el.appendTo('body')

  test 'render() changes the view element to the <html> tag in the iframe', ->
    $el = @view.$el
    @view.render()

    assert.equal @view.el, $el.contents().find('html').get(0)

  test 'render() adds the <style> tag', ->
    @view.render()

    assert.lengthOf @view.$('#canvas-css'), 1

  test "dragEnter() adds .app-over class to it's target", ->
    $div = $('<div>')
    e = $.Event('dragenter', target: $div.get(0))
    @view.dragEnter(e)

    assert.isTrue $div.hasClass('app-over')

  test "dragLeave() adds .app-over class to it's target", ->
    $div = $('<div class="app-over">')
    e = $.Event('dragleave', target: $div.get(0))
    @view.dragLeave(e)

    assert.isFalse $div.hasClass('app-over')

  test 'cleanup() removes .app-over class from all children elements', ->
    $div = $('<div class="app-over">').appendTo(@view.render().$el)
    @view.cleanup()

    assert.isFalse $div.hasClass('app-over')

  test 'selectElement() adds .app-current class to the element', ->
    $target = $('<div>')

    @view
      .setElement('<div><div class="app-current"></div></div>')
      .$el.append($target)

    e = new $.Event('click', target: $target.get(0))
    @view.selectElement(e)

    assert.isTrue $target.hasClass('app-current')
    assert.lengthOf @view.$('.app-current'), 1

  test "selectElement() doesn't add .app-current class to the body", ->
    $target = $('<body>')

    @view
      .setElement('<div><div class="app-current"></div></div>')
      .$el.append($target)

    e = new $.Event('click', target: $target.get(0))
    @view.selectElement(e)

    assert.isFalse $target.hasClass('app-current')
    assert.lengthOf @view.$('.app-current'), 0
