get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "num:", ->

  beforeEach ->
    Person = Em.Object.extend ValidateMixin

  afterEach ->
    person = null

  it "fail on string", ->

    Person = Person.extend
      validations:
        age: "num"
    
    person = Person.create
      age: "dew"
    person.validate()
    
    assert.equal get(person, "_errors.age"), "invalid"
    assert.equal get(person, "_isValid"), false

  
  it "pass if float", ->

    Person = Person.extend
      validations:
        age: "num"
    
    person = Person.create
      age: 22.0
    person.validate()

    assert.equal get(person, "_errors.age"), undefined
    assert.equal get(person, "_isValid"), true

  
  it "pass if +ve with positive = true", ->

    Person = Person.extend
      validations:
        age:
          num:
            positive: true
    
    person = Person.create
      age: 0

    person.validate()
    assert.equal get(person, "_errors.age"), "invalid"
    assert.equal get(person, "_isValid"), false

    set person, "age", -22
    person.validate()
    assert.equal get(person, "_errors.age"), "invalid"
    assert.equal get(person, "_isValid"), false

    set person, "age", 22
    person.validate()
    assert.equal get(person, "_errors.age"), undefined
    assert.equal get(person, "_isValid"), true


  it "pass if -ve with negative = true", ->

    Person = Person.extend
      validations:
        age:
          num:
            negative: true

    person = Person.create()

    set person, "age", 0
    person.validate()
    assert.equal get(person, "_errors.age"), "invalid"
    assert.equal get(person, "_isValid"), false

    set person, "age", 22
    person.validate()
    assert.equal get(person, "_errors.age"), "invalid"
    assert.equal get(person, "_isValid"), false

    set person, "age", -22
    person.validate()
    assert.equal get(person, "_errors.age"), undefined
    assert.equal get(person, "_isValid"), true

  it "fail if 0 with zero==false", ->

    Person = Person.extend
      validations:
        age: "num"
    
    person = Person.create
      age: 0

    person.validate()
    assert.equal get(person, "_errors.age"), "invalid"
    assert.equal get(person, "_isValid"), false


  it "pass if 0 with zero==true", ->

    Person = Person.extend
      validations:
        age:
          num:
            zero: true

    person = Person.create()

    set person, "age", 0
    person.validate()
    assert.equal get(person, "_errors.age"), undefined
    assert.equal get(person, "_isValid"), true
