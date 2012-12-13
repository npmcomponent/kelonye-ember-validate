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

describe "max:", ->

  beforeEach ->
    Person = Em.Object.extend require("./../index")

  afterEach ->
    person = null

  it "fail", ->

    Person = Person.extend
      validations:
        name:
          max: 2

    person = Person.create
      name: "Yehuda"

    person.validate()
    assert get(person, "_errors.name.msg") is "Long"
    assert get(person, "_isValid") is false

  it "pass", ->

    Person = Person.extend
      validations:
        name:
          max: 5
    
    person = Person.create
      "name": "Tom"

    person.validate()
    assert get(person, "_errors.name.msg") is undefined
    assert get(person, "_isValid") is true

  it "pass if ==", ->

    Person = Person.extend
      validations:
        name:
          max:
            max: 3
            equal: true
    
    person = Person.create
      "name": "Tom"

    person.validate()
    assert get(person, "_errors.name.msg") is undefined
    assert get(person, "_isValid") is true
