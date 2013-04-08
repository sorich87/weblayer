class Weblayer.Views.ContextMenuItem extends Backbone.View

  tagName: 'li'

  template: JST['context_menu/item']

  render: =>
    @$el
      .html(@template(item: @model))
      .addClass(@model.get('name'))
    @
