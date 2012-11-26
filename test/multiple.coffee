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
    person.get("_errors.tel.msg").should.equal ""
    person.get("_isValid").should.be.false

    person.set "tel", "2547"
    person.validate()
    person.get("_errors.tel.msg").should.equal "Short"
    person.get("_isValid").should.be.false

    person.set "tel", "2547001110001111"
    person.validate()
    person.get("_errors.tel.msg").should.equal "Long"
    person.get("_isValid").should.be.false

    person.set "tel", "254000111222"
    person.validate()
    person.get("_errors.tel.msg").should.equal "Number is invalid"
    person.get("_isValid").should.be.false

    person.set "tel", "254700111222"
    person.validate()
    person.get("_isValid").should.be.false

    person.set "name", "Peter Wagenet"
    person.validate()
    person.get("_isValid").should.be.true

    store.commit()
    person.get("isSaving" ).should.be.true
    
