Em = window.Em
DS = window.DS

get = Em.get
set = Em.set

Person = window.Person
person = window.person
adapter = window.adapter
store = window.store

describe "Min:", ->

  beforeEach ->

    Person = DS.Model.extend Em.V,
      name: DS.attr "string"
      tel: DS.attr "string"

    Person.toString = ->
      "App.Person"

    adapter = DS.RESTAdapter.create

      updateRecord: (store, type, record) ->

    store = DS.Store.create
      revision: 4
      adapter: adapter
    
    person = store.createRecord Person

  afterEach ->
    store.destroy()
    adapter.destroy()
    person = null


  it "@min required", ->

    person.setProperties
      "name": "Yehuda"
      "validations": [
        {
          on: "name"
          validators: [
            Em.MinV.create()
          ]
        }
      ]

    expect(person.validate).toThrow()
  
  it "fail", ->
    person.setProperties
      "name": "Yehuda"
      "validations": [
        {
          on: "name"
          validators: [
            Em.MinV.create
              min: 7
          ]
        }
      ]

    person.validate()
    expect(person.get "_errors.name.msg").toEqual "Short"
    expect(person.get "_isValid").toBeFalsy()


  it "pass", ->
    person.setProperties
      "name": "Tom"
      "validations": [
        {
          on: "name"
          validators: [
            Em.MinV.create
              min: 2
          ]
        }
      ]

    person.validate()
    expect(person.get "_errors.name.msg").not.toBeDefined()
    expect(person.get "_isValid").toBeTruthy()
    store.commit()
    expect(person.get "isSaving" ).toBeTruthy()

  it "pass if ==", ->
    person.setProperties
      "name": "Tom"
      "validations": [
        {
          on: "name"
          validators: [
            Em.MinV.create
              min: 3
              equal: true
          ]
        }
      ]

    person.validate()
    expect(person.get "_errors.name.msg").not.toBeDefined()
    expect(person.get "_isValid").toBeTruthy()
