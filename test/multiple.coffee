Em = window.Em
DS = window.DS

get = Em.get
set = Em.set

Person = window.Person
person = window.person
adapter = window.adapter
store = window.store

describe "Multiple:", ->

  beforeEach ->

    Person = DS.Model.extend Em.V,
      name: DS.attr "string"
      tel: DS.attr "string"
      validations: [
        {
          on: "name"
          validators: [
            Em.PresenceV.create()
          ]
        }
        {
          on: "tel"
          validators: [
            Em.PresenceV.create()
            Em.MinV.create
              min: 9
              equal: true
            Em.MaxV.create
              max: 13
              equal: true
            Em.RegV.create
              msg: "Number is invalid" 
              exp: /^(?:0|\+?254)7\d{8}$/
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


  it "do", ->
    
    person.validate()
    expect(person.get "_errors.tel.msg").toEqual ""
    expect(person.get "_isValid").toBeFalsy()

    person.set "tel", "2547"
    person.validate()
    expect(person.get "_errors.tel.msg").toEqual "Short"
    expect(person.get "_isValid").toBeFalsy()

    person.set "tel", "2547001110001111"
    person.validate()
    expect(person.get "_errors.tel.msg").toEqual "Long"
    expect(person.get "_isValid").toBeFalsy()

    person.set "tel", "254000111222"
    person.validate()
    expect(person.get "_errors.tel.msg").toEqual "Number is invalid"
    expect(person.get "_isValid").toBeFalsy()

    person.set "tel", "254700111222"
    person.validate()
    expect(person.get "_isValid").toBeFalsy()

    person.set "name", "Peter Wagenet"
    person.validate()
    expect(person.get "_isValid").toBeTruthy()

    store.commit()
    expect(person.get "isSaving" ).toBeTruthy()
    
