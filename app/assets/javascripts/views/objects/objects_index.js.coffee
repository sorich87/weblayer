class Weblayer.Views.ObjectsIndex extends Backbone.View

  id: 'app-objects-index'
  className: 'accordion'

  initialize: ->
    @collection.on('add', @addObjectView)

  render: =>
    @$el.empty()
    @collection.each (object) =>
      (new Weblayer.Views.ObjectItem(model: object)).render().$el
        .appendTo(@$el)
    @

  addObjectView: (object) =>
    (new Weblayer.Views.ObjectItem(model: object)).render().$el
      .appendTo(@$el)
      .find('.collapse').collapse(parent: @$el)
