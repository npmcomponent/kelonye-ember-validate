get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "max:", ->

  beforeEach ->
    Person = Em.Object.extend ValidateMixin

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
    assert.equal get(person, "_errors.name"), "Long"
    assert.equal get(person, "_isValid"), false

  it "pass", ->

    Person = Person.extend
      validations:
        name:
          max: 5
    
    person = Person.create
      "name": "Tom"

    person.validate()
    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_isValid"), true

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
    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_isValid"), true
