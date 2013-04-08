class Weblayer.Views.Canvas extends Backbone.View

  tagName: 'iframe'

  events:
    'dragenter': 'dragEnter'
    'dragleave': 'dragLeave'
    'dragover': 'dragOver'
    'drop': 'drop'

  initialize: ->
    Backbone.on('drag:end', @cleanup)

  render: =>
    @setElement(@$el.contents().find('html'))
    @addCss()
    @

  dragEnter: (e) =>
    $(e.target).addClass('app-over')

  dragLeave: (e) =>
    $(e.target).removeClass('app-over')

  cleanup: (e) =>
    @$('.app-over').removeClass('app-over')

  dragOver: (e) =>
    e.preventDefault()
    e.originalEvent.dataTransfer.dropEffect = 'move'
    false

  drop: (e) =>
    e.stopPropagation()
    html = e.originalEvent.dataTransfer.getData('html')
    $(e.target).append(html)
    false

  addCss: =>
    $style = $('<style id="canvas-css">').text(JST['canvas/css'])
    @$('head')
      .append('<link rel="stylesheet" href="/app/bootstrap.min.css" />')
      .append('<link rel="stylesheet" href="/app/bootstrap-responsive.min.css" />')
      .append($style)
