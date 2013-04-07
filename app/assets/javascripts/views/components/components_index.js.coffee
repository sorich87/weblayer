class Weblayer.Views.ComponentsIndex extends Backbone.View

  tagName: 'ul'
  className: 'app-components'

  render: =>
    @collection.each (component) =>
      (new Weblayer.Views.ComponentItem(model: component)).render().$el
        .appendTo(@$el)
    @
