class Weblayer.Views.Canvas extends Backbone.View

  tagName: 'iframe'

  events:
    'click': 'selectElement'
    'contextmenu': 'selectElement'
    'mouseenter :not(body,.app-dragging)': 'makeDraggable'
    'mouseout :not(body,.app-dragging)': 'removeDraggable'
    'dragstart [draggable]': 'dragStart'
    'dragend': 'dragEnd'
    'dragenter :not(.app-dragging)': 'dragEnter'
    'dragover :not(.app-dragging)': 'dragOver'
    'drop :not(.app-dragging)': 'drop'

  initialize: ->
    Backbone.on('drag:start', @setup)
    Backbone.on('drag:end', @cleanup)

  render: =>
    @setElement(@$el.contents().find('html'))
    @addCss()
    @

  addCss: =>
    $style = $('<style id="canvas-css">').text(JST['canvas/css'])
    @$('head')
      .append('<link rel="stylesheet" href="/app/bootstrap.min.css" />')
      .append('<link rel="stylesheet" href="/app/bootstrap-responsive.min.css" />')
      .append($style)

  selectElement: (e) =>
    @$('.app-current').removeClass('app-current')
    $(e.target).addClass('app-current') unless e.target.tagName == 'BODY'

  makeDraggable: (e) =>
    $(e.target).attr('draggable', 'true')

  removeDraggable: (e) =>
    $(e.target).removeAttr('draggable')

  dragStart: (e) =>
    Backbone.trigger('drag:start', $(e.target))

    e.originalEvent.dataTransfer.effectAllowed = 'move'
    e.originalEvent.dataTransfer.setData('text', 'dragging')

  dragEnd: =>
    Backbone.trigger('drag:end')

  setup: ($element) =>
    @$dragging = $element
    @$plus = $('<div class="app-plus">+</div>')

  cleanup: () =>
    @cleanDraggables()
    @cleanClasses()
    @$plus.remove()
    @$dragging = @$plus = null

  dragEnter: (e) =>
    @cleanClasses() unless @$plus.is(e.target)

    unless @$plus.is(e.target) || e.target.tagName == 'BODY'
      $(e.target).addClass('app-over').after(@$plus)
        .parent().addClass('app-over-parent')

  dragOver: (e) =>
    e.preventDefault()
    e.originalEvent.dataTransfer.dropEffect = 'move'
    false

  drop: (e) =>
    e.stopPropagation()
    if @$plus.is(e.target)
      @$plus.replaceWith(@$dragging)
    else
      @$dragging.appendTo(e.target)
    false

  cleanClasses: =>
    @$('.app-over,.app-over-parent').removeClass('app-over app-over-parent')

  cleanDraggables: =>
    @$('[draggable]').removeAttr('draggable')
