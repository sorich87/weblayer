class Weblayer.Models.Object extends Backbone.Model

  urlRoot: '/objects'

  defaults:
    title: ""
    class_name: ""
    fields: []

  initialize: ->
    @on('change:fields', @parseFields)
    @parseFields()

  parseFields: =>
    @fields = new Weblayer.Collections.ObjectFields(@get('fields'))

  toJSON: =>
    @json = _.clone(@attributes)
    @json.fields = @fields.map (field) ->
      name: field.get('name')
      type: field.get('type')
    @json
