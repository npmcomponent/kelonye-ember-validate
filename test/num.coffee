Em = window.Em
DS = window.DS

get = Em.get
set = Em.set

Person = window.Person
person = window.person
adapter = window.adapter
store = window.store

describe "Presence:", ->

  beforeEach ->

    Person = DS.Model.extend Em.V,
      name: DS.attr "string"
      age: DS.attr "number"
      validations: [
        {
          on: "age"
          validators: [
            Em.NumV.create()
          ]
        }
      ]

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

  it "fail on string", ->
    person.set "age", "dew"
    person.validate()
    expect(person.get "_errors.age.msg").toEqual "invalid"
    expect(person.get "_isValid").toBeFalsy()

  it "pass if float", ->

    person.set "age", 22.0
    person.validate()
    expect(person.get "_errors.age.msg").not.toBeDefined()
    expect(person.get "_isValid").toBeTruthy()
    store.commit()
    expect(person.get "isSaving" ).toBeTruthy()

  it "pass if +ve with positive = true", ->

    person.validations = [
        {
          on: "age"
          validators: [
            Em.NumV.create
              positive: true
          ]
        }
      ]
    person.set "age", 0
    person.validate()
    expect(person.get "_errors.age.msg").toEqual "invalid"
    expect(person.get "_isValid").toBeFalsy()

    person.set "age", -22
    person.validate()
    expect(person.get "_errors.age.msg").toEqual "invalid"
    expect(person.get "_isValid").toBeFalsy()

    person.set "age", 22
    person.validate()
    expect(person.get "_errors.age.msg").not.toBeDefined()
    expect(person.get "_isValid").toBeTruthy()
    store.commit()
    expect(person.get "isSaving" ).toBeTruthy()


  it "pass if -ve with negative = true", ->

    person.validations = [
        {
          on: "age"
          validators: [
            Em.NumV.create
              negative: true
          ]
        }
      ]

    person.set "age", 0
    person.validate()
    expect(person.get "_errors.age.msg").toEqual "invalid"
    expect(person.get "_isValid").toBeFalsy()

    person.set "age", 22
    person.validate()
    expect(person.get "_errors.age.msg").toEqual "invalid"
    expect(person.get "_isValid").toBeFalsy()

    person.set "age", -22
    person.validate()
    expect(person.get "_errors.age.msg").not.toBeDefined()
    expect(person.get "_isValid").toBeTruthy()
    store.commit()
    expect(person.get "isSaving" ).toBeTruthy()


  it "fail if 0 with zero==false", ->

    person.validations = [
        {
          on: "age"
          validators: [
            Em.NumV.create()
          ]
        }
      ]

    person.set "age", 0
    person.validate()
    expect(person.get "_errors.age.msg").toEqual "invalid"
    expect(person.get "_isValid").toBeFalsy()


  it "pass if 0 with zero==true", ->

    person.validations = [
        {
          on: "age"
          validators: [
            Em.NumV.create
              zero: true
          ]
        }
      ]

    person.set "age", 0
    person.validate()
    expect(person.get "_errors.age.msg").not.toBeDefined()
    expect(person.get "_isValid").toBeTruthy()
    store.commit()
    expect(person.get "isSaving" ).toBeTruthy()

