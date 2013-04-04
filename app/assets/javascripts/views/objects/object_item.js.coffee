class Weblayer.Views.ObjectItem extends Backbone.View

  className: 'accordion-group'

  template: JST['objects/item']

  render: =>
    @$el.html(@template(object: @model))
    @
