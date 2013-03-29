window.Weblayer =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    (new @Views.DeviceSwitch(iframe: "#app-preview iframe")).render()
      .$el.appendTo("#app-controls-header")

$(document).ready ->
  Weblayer.initialize()

