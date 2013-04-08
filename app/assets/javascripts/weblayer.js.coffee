window.Weblayer =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Defaults: {}

  initialize: (data) ->
    @devices = new @Collections.Devices(@Defaults.devices)
    @components = new @Collections.Components(@Defaults.components)
    @objects = new @Collections.Objects(data.objects)

    canvasView = (new @Views.Canvas())
    # To work properly, the canvas view needs to be rendered after
    # the iframe was appended to the DOM
    $iframe = canvasView.$el.appendTo('#app-preview')
    canvasView.render()

    (new @Views.DevicesIndex
      collection: @devices
      $iframe: $iframe
    ).render().$el.appendTo("#app-controls-header")

    $('#app-controls-views')
      .append((new @Views.ComponentsIndex(collection: @components)).render().$el)

    $('#app-controls-objects')
      .append((new @Views.ObjectsIndex(collection: @objects)).render().$el)
      .append((new @Views.ObjectsNew(collection: @objects)).render().$el)

    $('body')
      .append((new @Views.ContextMenu($iframe: $iframe)).render().$el)
