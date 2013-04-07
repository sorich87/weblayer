class Weblayer.Views.ComponentItem extends Backbone.View

  tagName: 'li'

  template: JST['components/item']

  events:
    'dragstart a': 'dragStart'
    'dragend *': 'dragEnd'

  render: =>
    @$el.html(@template(component: @model))
      .find('a').tooltip
        placement: 'right'
        container: 'body'
    @

  dragStart: (e) =>
    @$('a').tooltip('hide')
    html = @model.get('html')
    e.originalEvent.dataTransfer.effectAllowed = 'move'
    e.originalEvent.dataTransfer.setData('html', html)

  dragEnd: (e) =>
    Backbone.trigger('drag:end')
