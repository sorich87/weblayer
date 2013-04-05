class Weblayer.Views.ObjectsIndex extends Backbone.View

  id: 'app-objects-index'
  className: 'accordion'

  initialize: ->
    @collection.on('add', @render)
    @collection.on('remove', @render)
    @collection.on('reset', @render)

  render: =>
    @$el.empty()
    @collection.each (object) =>
      @subView(object).render().$el
        .appendTo(@$el)
    @

  subView: (object) =>
    @subViews ||= {}
    @subViews[object.cid] ||= new Weblayer.Views.ObjectItem(model: object)
