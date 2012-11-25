Em = window.Em
DS = window.DS

get = Em.get
set = Em.set

Person = window.Person
person = window.person
adapter = window.adapter
store = window.store

describe "Reg:", ->

  beforeEach ->

    Person = DS.Model.extend Em.V,
      name: DS.attr "string"
      tel: DS.attr "string"
      validations: [
        {
          on: "tel"
          validators: [
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

  it "fail", ->

    person.set "tel", "254000111222"
    person.validate()
    expect(person.get "_errors.tel.msg").toEqual "Number is invalid"
    expect(person.get "_isValid").toBeFalsy()

  it "pass", ->

    person.set "tel", "254700111222"
    person.validate()
    expect(person.get "_isValid").toBeTruthy()

    store.commit()
    expect(person.get "isSaving" ).toBeTruthy()

