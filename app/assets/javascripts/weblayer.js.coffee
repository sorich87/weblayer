window.Weblayer =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  devices: [
    {
      title: 'PC',
      name: 'desktop'
      width: '100%',
      active: true
    },
    {
      title: 'Tablet',
      name: 'tablet',
      width: '768px',
    },
    {
      title: 'Phone',
      name: 'mobile-phone',
      width: '480px',
    }
  ]

  initialize: (data) ->
    @devices = new @Collections.Devices(@devices)

    devicesIndexView = new @Views.DevicesIndex
      collection: @devices
      $iframe: $('#app-preview iframe')
    devicesIndexView.render()
      .$el.appendTo("#app-controls-header")

