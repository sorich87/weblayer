class Weblayer.Views.ObjectsNew extends Backbone.View

  tagName: "form"
  className: "app-objects-new form-inline"

  template: JST["objects/new"]

  events:
    "submit": "save"

  initialize: ->
    @newObject()

  newObject: =>
    @model = new Weblayer.Models.Object()

  render: =>
    @$el.html(@template)
    @

  save: (e) =>
    e.preventDefault()

    @model.set(title: @$('input[name=title]').val())
    @model.save({}, success: @saved)

  saved: =>
    @collection.add(@model)
    @newObject()
    @render()
