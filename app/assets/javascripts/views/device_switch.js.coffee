class Weblayer.Views.DeviceSwitch extends Backbone.View

  template: JST["device_switch"]
  className: "device-switch"
  events:
    "click a": "switch"

  initialize: ->

  render: =>
    @$el.html(@template)
    @

  switch: (e) =>
    e.preventDefault()

    $button = @$(e.currentTarget)
    $button.addClass("active")
      .siblings().removeClass("active")

    device = $button.data("device")
    $(@options.iframe).animate(width: @deviceWidth(device))

  deviceWidth: (device) =>
    switch device
      when "phone" then "480px"
      when "tablet" then "768px"
      else "100%"

