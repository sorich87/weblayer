#=require test_helper

suite 'Weblayer.Views.ContextMenu', ->

  setup ->
    $iframe = $('<iframe>').appendTo('body')
    @view = (new Weblayer.Views.ContextMenu($iframe: $iframe))

  suite 'initialize()', ->
    test 'loads a context menu items collection', ->
      assert.ok @view.collection.length > 0
      assert.equal @view.collection.length, @view.items().length

  suite 'render()', ->
    test 'renders the context menu items', ->
      @view.render()
      @view.items().forEach (item) =>
        assert.include @view.$el.html(), item.name

  suite 'show()', ->

    suite 'on every tag', ->
      setup ->
        @view.render()
        @$div = $('<div class="test">').appendTo('body')
        @e = $.Event('contextmenu', target: @$div[0])

      test 'shows the view element', ->
        @view.show(@e)
        assert.equal @view.$el.css('display'), 'block'

      test 'position the view element', ->
        @view.$iframe.offset(left: 50, top: 100)
        @e.pageX = 50
        @e.pageY = 100
        spy = sinon.spy(@view.$el, 'css')
        @view.show(@e)

        assert.ok spy.calledWith(left: 100, top: 200)

      test 'sets the selected element', ->
        @view.show(@e)
        assert.ok @view.$selected.is(@$div)

      test 'enables copy/cut/delete', ->
        @view.show(@e)
        ['copy', 'cut', 'delete'].forEach (action) =>
          assert.isFalse @view.$('li.' + action).hasClass('disabled')

      test 'enables paste if clipboard', ->
        @view.$clipboard = @$div.clone()
        @view.show(@e)
        assert.isFalse @view.$('li.paste').hasClass('disabled')

      test 'disables paste if no clipboard', ->
        @view.show(@e)
        assert.ok @view.$('li.paste').hasClass('disabled')

    suite 'on <body>', ->
      test 'disables copy/cut/delete', ->
        e = $.Event('contextmenu', target: document.body)
        @view.render().show(e)

        ['copy', 'cut', 'delete'].forEach (action) =>
          assert.ok @view.$('li.' + action).hasClass('disabled')

  suite 'hide()', ->

    test 'hides the view element', ->
      @view.hide(@e)
      assert.equal @view.$el.css('display'), 'none'

  suite 'doAction()', ->

    test 'calls targeted action', ->
      @view.$selected = $('<div class="test">')

      ['copy', 'cut', 'delete', 'paste'].forEach (action) =>
        spy = sinon.spy(@view, action)
        @view.render()
        e = $.Event('click', target: @view.$('li.' + action + ' a')[0])
        @view.doAction(e)

        assert.ok spy.calledOnce

    test 'calls paste on body', ->
      spy = sinon.spy(@view, 'paste')

      @view.$selected = $('<div class="test">')
      @view.$clipboard = $('<div class="test">')
      @view.render()

      e = $.Event('click', target: @view.$('li.paste a')[0])
      @view.doAction(e)

      assert.ok spy.calledOnce

    test "calls only paste on body", ->
      @view.$selected = $(document.body)

      ['copy', 'cut', 'delete'].forEach (action) =>
        spy = sinon.spy(@view, action)
        @view.render()
        e = $.Event('click', currentTarget: @view.$('li.' + action + ' a')[0])
        @view.doAction(e)

        assert.isFalse spy.calledOnce

  suite 'copy()', ->
    setup ->
      @view.$selected = $('<div class="test">').appendTo(document.body)
      @view.$el.append('<li class="paste disabled">')
      @view.copy()

    test 'clones the selected element as clipboard', ->
      assert.ok @view.$clipboard.hasClass('test')

    test 'enables paste', ->
      assert.isFalse @view.$('.paste').hasClass('disabled')

  suite 'paste()', ->
    setup ->
      @view.$clipboard = $('<div class="clipboard">')

    test 'inserts a clone of clipboard after selected element', ->
      @view.$selected = $('<div class="test">').appendTo(document.body)
      @view.paste()

      assert.lengthOf $(document.body).children('.clipboard'), 1

    test 'appends a clone of clipboard to the body', ->
      @view.$selected = $(document.body)
      @view.paste()

      assert.lengthOf $(document.body).children('.clipboard'), 1

  suite 'delete()', ->

    test 'remove the selected element', ->
      @view.$selected = $('<div class="test">').appendTo(document.body)
      @view.delete()

      assert.lengthOf @view.$selected.parent(), 0

  suite 'cut()', ->

    test 'cut() copies then deletes', ->
      @view.$selected = $('<div class="test">')
      copySpy = sinon.spy(@view, 'copy')
      deleteSpy = sinon.spy(@view, 'delete')
      @view.cut()

      assert.ok copySpy.calledOnce
      assert.ok deleteSpy.calledAfter(copySpy)
