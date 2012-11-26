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
    person.get("_errors.age.msg").should.equal "invalid"
    person.get("_isValid").should.be.false

  it "pass if float", ->

    person.set "age", 22.0
    person.validate()
    #should.not.exist person.get("_errors.age.msg")
    person.get("_isValid").should.be.true
    store.commit()
    person.get("isSaving" ).should.be.true

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
    person.get("_errors.age.msg").should.equal "invalid"
    person.get("_isValid").should.be.false

    person.set "age", -22
    person.validate()
    person.get("_errors.age.msg").should.equal "invalid"
    person.get("_isValid").should.be.false

    person.set "age", 22
    person.validate()
    #should.not.exist person.get("_errors.age.msg")
    person.get("_isValid").should.be.true
    store.commit()
    person.get("isSaving" ).should.be.true


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
    person.get("_errors.age.msg").should.equal "invalid"
    person.get("_isValid").should.be.false

    person.set "age", 22
    person.validate()
    person.get("_errors.age.msg").should.equal "invalid"
    person.get("_isValid").should.be.false

    person.set "age", -22
    person.validate()
    #should.not.exist person.get("_errors.age.msg")
    person.get("_isValid").should.be.true
    store.commit()
    person.get("isSaving" ).should.be.true


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
    person.get("_errors.age.msg").should.equal "invalid"
    person.get("_isValid").should.be.false


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
    #should.not.exist person.get("_errors.age.msg")
    person.get("_isValid").should.be.true
    store.commit()
    person.get("isSaving" ).should.be.true

