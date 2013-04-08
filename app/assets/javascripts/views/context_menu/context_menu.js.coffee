class Weblayer.Views.ContextMenu extends Backbone.View

  tagName: 'ul'
  className: 'context-menu dropdown-menu'

  events: ->
    'click a': 'doAction'

  initialize: ->
    @collection = new Weblayer.Collections.ContextMenuItems(@items())
    @$iframe = @options.$iframe
    @$iframe.contents()
      .on('contextmenu', '*', @show)
      .on('click', @hide)
    $(document).on('click', @hide)

  render: =>
    @collection.each (item) =>
      (new Weblayer.Views.ContextMenuItem(model: item)).render()
        .$el.appendTo(@$el)
    @

  items: =>
    ['copy', 'paste', 'cut', 'delete'].map (action) -> {name: action}

  show: (e) =>
    e.preventDefault()

    @$selected = $(e.target)
    @toggleActions()
    @setPosition(e)
    @$el.show()

  hide: (e) =>
    unless @$(e.target).parent().hasClass('disabled')
      @$el.hide()

  setPosition: (e) =>
    iframeOffset = @$iframe.offset()
    left = e.pageX + iframeOffset.left
    top = e.pageY + iframeOffset.top
    @$el.css(left: left, top: top)

  toggleActions: () =>
    @$('li:not(paste)').toggleClass('disabled', @$selected.is('body'))
    @$('li.paste').toggleClass('disabled', ! @$clipboard?.length)

  doAction: (e) =>
    e.preventDefault()

    $li = @$(e.target).parent()

    return if $li.hasClass('disabled')

    action = @$(e.target).parent().attr('class')

    unless @$selected.is('body') && action != 'paste'
      @[action]()

  copy: ->
    @$clipboard = @$selected.clone()
    @$('.paste').removeClass('disabled')

  paste: () ->
    $clone = @$clipboard.clone()

    if @$selected.is('body')
      $clone.appendTo(@$selected)
    else
      $clone.insertAfter(@$selected)

  cut: ->
    @copy()
    @delete()

  delete: ->
    @$selected.remove()
