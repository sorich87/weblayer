class Weblayer.Views.ObjectItem extends Backbone.View

  className: 'accordion-group'

  template: JST['objects/item']

  events:
    'click .app-objects-field-new': 'addField'

  initialize: ->
    @model.save = _.debounce(@model.save, 500)
    @model.fields.on('change', @save)

  render: =>
    @$el.html(@template(object: @model))
    @model.fields.each(@appendFieldView)
    @

  appendFieldView: (field) =>
    view = new Weblayer.Views.ObjectField(model: field).render()
    @$('.accordion-inner').append(view.$el)

  addField: =>
    field = new Weblayer.Models.ObjectField()
    @appendFieldView(field)
    @model.fields.add(field)

  save: =>
    @model.save()
