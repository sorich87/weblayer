class Weblayer.Views.ObjectField extends Backbone.View

  className: 'app-object-field form-inline'

  template: JST['objects/field']

  events:
    'keyup input': 'edit'
    'change input,select': 'edit'
    'click .remove': 'remove'

  render: =>
    @$el.html(@template(field: @model, typeOptions: @typeOptions))
    @

  edit: (e) =>
    $target = this.$(e.currentTarget)
    attribute_name = $target.attr('name')
    attribute_value = $target.val()
    @model.set(attribute_name, attribute_value)

  remove: =>
    @model.destroy()
    @$el.remove()
    @off()

  typeOptions: (field) ->
    options = ['string', 'text', 'integer', 'float', 'decimal', 'datetime',
      'timestamp', 'time', 'date', 'binary', 'boolean']

    options = options.map (type) =>
      if field.get('type') == type
        selected = ' selected="selected"'
      else
        selected = ''
      '<option' + selected + '>' + type + '</option>'

    @safe options.join('')
