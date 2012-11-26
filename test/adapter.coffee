global.window = require("jsdom").jsdom().createWindow()
jQuery = require("jquery")
require "handlebars"
require "ember"
global.window.Em = Ember
require "./../components/kelonye-data"
require "./../index"
require "should"

get = Em.get
set = Em.set

Person = window.Person
person = window.person
adapter = window.adapter
store = window.store

describe "Adapter:", ->

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


  afterEach ->
    store.destroy()
    adapter.destroy()
    person = null


  it "store creation", ->

    person = store.createRecord Person
    
    person.validate()
    #expect(person.get "_errors.name.msg").toEqual ""
    person.get("_isValid").should.be.false

    person.set "name", "Yehuda"
    person.validate()
    #should.not.exist person.get("_errors.name.msg")
    person.get("_isValid").should.be.true
    store.commit()
    person.get("isSaving" ).should.be.true


