#= require test_helper

suite 'Weblayer.Views.Canvas', ->

  setup ->
    @view = new Weblayer.Views.Canvas()
    @view.$el.appendTo('body')

  suite 'render()', ->

    test 'changes the view element to the <html> tag in the iframe', ->
      $el = @view.$el
      @view.render()

      assert.equal @view.el, $el.contents().find('html').get(0)

    test 'adds the <style> tag', ->
      @view.render()

      assert.lengthOf @view.$('#canvas-css'), 1

  suite 'dragEnter()', ->

    test "adds .app-over class to it's target", ->
      @view.setup('<div></div>')
      $div = $('<div>')
      e = $.Event('dragenter', target: $div.get(0))
      @view.dragEnter(e)

      assert.isTrue $div.hasClass('app-over')

  suite 'cleanup()', ->

    test 'removes .app-over class from all children elements', ->
      @view.setup('<div></div>')
      $div = $('<div class="app-over">').appendTo(@view.render().$el)
      @view.cleanup()

      assert.isFalse $div.hasClass('app-over')

  suite 'selectElement()', ->

    test 'adds .app-current class to the element', ->
      $target = $('<div>')

      @view
        .setElement('<div><div class="app-current"></div></div>')
        .$el.append($target)

      e = new $.Event('click', target: $target.get(0))
      @view.selectElement(e)

      assert.isTrue $target.hasClass('app-current')
      assert.lengthOf @view.$('.app-current'), 1

    test "doesn't add .app-current class to the body", ->
      $target = $('<body>')

      @view
        .setElement('<div><div class="app-current"></div></div>')
        .$el.append($target)

      e = new $.Event('click', target: $target.get(0))
      @view.selectElement(e)

      assert.isFalse $target.hasClass('app-current')
      assert.lengthOf @view.$('.app-current'), 0
