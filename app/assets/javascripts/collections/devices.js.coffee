class Weblayer.Collections.Devices extends Backbone.Collection

  model: Weblayer.Models.Device

  initialize: ->
    @on('change', @ensureOneActive)

  active: ->
    @findWhere(active: true) || @first()

  ensureOneActive: (changed) =>
    if changed.get('active')
      @each (device) =>
        if device.cid != changed.cid
          device.set('active', false)
