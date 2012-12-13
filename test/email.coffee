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

describe "email:", ->

  beforeEach ->

    Person = Em.Object.extend require("./../index"),
      validations:
        email: "email"

    person = Person.create
      email: "g"

  afterEach ->
    person = null

  it "", ->

    person.validate()
    
    assert get(person, "_errors.email.msg") is "Wrong email format"
    assert get(person, "_errors.email._isValid") is false
    assert get(person, "_isValid") is false

    set person, "email", "jc.c"
    person.validate()

    assert get(person, "_errors.email.msg") is "Wrong email format"
    assert get(person, "_errors.email._isValid") is false
    assert get(person, "_isValid") is false

    set person, "email", "j@c.c"
    person.validate()

    assert get(person, "_errors.email.msg") is undefined
    assert get(person, "_errors.email._isValid") is true
    assert get(person, "_isValid") is true
