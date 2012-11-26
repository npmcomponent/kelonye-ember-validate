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

    person.validate.should.throw()
  
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
    person.get("_errors.name.msg").should.equal "Short"
    person.get("_isValid").should.be.false


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
    #should.not.exist person.get("_errors.name.msg")
    person.get("_isValid").should.be.true
    store.commit()
    person.get("isSaving" ).should.be.true

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
    #should.not.exist person.get("_errors.name.msg")
    person.get("_isValid").should.be.true
