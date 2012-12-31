get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "min", ->

  beforeEach ->
    Person = Em.Object.extend ValidateMixin

  afterEach ->
    person = null

  it "fail", ->

    Person = Person.extend
      validations:
        name:
          min: 10

    person = Person.create
      name: "Yehuda"

    person.validate()
    assert.equal get(person, "_errors.name"), "Short"
    assert.equal get(person, "_isValid"), false


  it "pass", ->

    Person = Person.extend
      validations:
        name:
          min: 2

    person = Person.create
      name: "Tom"

    person.validate()
    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_isValid"), true

  it "pass if ==", ->

    Person = Person.extend
      validations:
        name:
          min:
            min: 3
            equal: true
    
    person = Person.create
      "name": "Tom"

    person.validate()
    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_isValid"), true
