get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "regex:", ->

  beforeEach ->

    Person = Em.Object.extend ValidateMixin,
      validations:
        tel: 
          re: /^(?:0|\+?254)7\d{8}$/

    person = Person.create
      tel: ""

  afterEach ->
    person = null

  it "fail", ->

    person.set "tel", "254000111222"
    person.validate()
    
    assert get(person, "_errors.tel.msg").indexOf("doesn't match") isnt -1
    assert get(person, "_isValid") is false

  it "pass", ->

    person.set "tel", "254700111222"
    person.validate()
    assert get(person, "_errors.tel.msg") is undefined
    assert get(person, "_isValid") is true

