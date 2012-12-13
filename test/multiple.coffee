global.window = require("jsdom").jsdom().createWindow()
jQuery = require("jquery")
require "handlebars"
require "ember"
global.window.Em = Ember

assert = require "assert"

get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "multiple:", ->

  beforeEach ->

    Person = Em.Object.extend require("./../index"),
      validations:
        name: "presence"
        tel:
          presence: true
          min:
            min: 9
            equal: true
          max:
            max: 13
            equal: true
          re:
            msg: "Number is invalid" 
            re: /^(?:0|\+?254)7\d{8}$/
    person = Person.create()

  afterEach ->
    person = null

  it "name and tel is absent", ->

    person.validate()

    assert get(person, "_errors.name.msg") is ""
    assert get(person, "_errors.tel.msg") is undefined
    assert get(person, "_errors.name._isValid") is false
    assert get(person, "_errors.tel._isValid") is true # validation not applied yet
    assert get(person, "_isValid") is false

  it "tel is too short", ->

    set person, "name", "TJ"
    set person, "tel", "2547"
    person.validate()

    assert get(person, "_errors.name.msg") is undefined
    assert get(person, "_errors.tel.msg") is "Short"
    assert get(person, "_errors.name._isValid") is true
    assert get(person, "_errors.tel._isValid") is false
    assert get(person, "_isValid") is false

  it "tel is too long", ->

    set person, "name", "TJ"
    set person, "tel", "2547001110001111"
    person.validate()

    assert get(person, "_errors.name.msg") is undefined
    assert get(person, "_errors.tel.msg") is "Long"
    assert get(person, "_errors.name._isValid") is true
    assert get(person, "_errors.tel._isValid") is false
    assert get(person, "_isValid") is false

  it "tel format is wrong", ->

    set person, "name", "TJ"
    set person, "tel", "254000111222"
    person.validate()

    assert get(person, "_errors.name.msg") is undefined
    assert get(person, "_errors.tel.msg") is "Number is invalid"
    assert get(person, "_errors.name._isValid") is true
    assert get(person, "_errors.tel._isValid") is false
    assert get(person, "_isValid") is false


  it "name and tel are ok", ->

    set person, "tel", "254700111222"
    person.validate()

    assert get(person, "_errors.name.msg") is ""
    assert get(person, "_errors.tel.msg") is undefined
    assert get(person, "_errors.name._isValid") is false
    assert get(person, "_errors.tel._isValid") is true
    assert get(person, "_isValid") is false

    set person, "name", "TJ"
    person.validate()

    assert get(person, "_errors.name.msg") is undefined
    assert get(person, "_errors.tel.msg") is undefined
    assert get(person, "_errors.name._isValid") is true
    assert get(person, "_errors.tel._isValid") is true
    assert get(person, "_isValid") is true

