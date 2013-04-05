#= require test_helper

suite 'Weblayer.Models.Object', ->

  setup ->
    @object = new Weblayer.Models.Object
      title: 'Test One'
      class_name: 'TestOne'
      fields: [
        {name: 'Field One', type: 'string'},
        {name: 'Field Two', type: 'float'}
      ]

  test "initialize() creates collections for it's fields", ->
    assert.instanceOf @object.fields, Weblayer.Collections.ObjectFields
    assert.lengthOf @object.fields, 2

  test 'change:fields event reparses the fields collection', ->
    @object.set(fields: [{name: 'Field Three', type: 'datetime'}])
    assert.lengthOf @object.fields, 1
