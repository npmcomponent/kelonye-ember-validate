get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "email:", ->

  beforeEach ->

    Person = Em.Object.extend ValidateMixin,
      validations:
        email: "email"

    person = Person.create
      email: "g"

  afterEach ->
    person = null

  it "test", ->

    person.validate()
    
    assert.equal get(person, "_errors.email"), "Wrong email format"
    assert.equal get(person, "_isValid"), false

    set person, "email", "jc.c"
    person.validate()

    assert.equal get(person, "_errors.email"), "Wrong email format"
    assert.equal get(person, "_isValid"), false

    set person, "email", "j@c.c"
    person.validate()

    assert.equal get(person, "_errors.email"), undefined
    assert.equal get(person, "_isValid"), true