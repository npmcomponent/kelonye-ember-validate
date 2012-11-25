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
      tel: DS.attr "string"
      validations: [
        {
          on: "name"
          validators: [
            Em.PresenceV.create()
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

    person.validate()
    expect(person.get "_errors.name.msg").toEqual ""
    expect(person.get "_isValid").toBeFalsy()

  it "pass", ->

    person.set "name", "Yehuda"
    person.validate()
    expect(person.get "_errors.name.msg").not.toBeDefined()
    expect(person.get "_isValid").toBeTruthy()
    store.commit()
    expect(person.get "isSaving" ).toBeTruthy()

