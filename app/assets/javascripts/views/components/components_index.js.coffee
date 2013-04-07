class Weblayer.Views.ComponentsIndex extends Backbone.View

  className: 'app-components'

  template: JST['components/index']

  render: =>
    @$el.html(@template())
    @collection.each (component) =>
      (new Weblayer.Views.ComponentItem(model: component)).render().$el
        .appendTo(@$('ul'))
    @
