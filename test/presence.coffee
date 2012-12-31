get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "presence:", ->

  beforeEach ->

    Person = Em.Object.extend ValidateMixin,
      validations:
        name: "presence"

    person = Person.create
      name: ""

  afterEach ->
    person = null

  it "", ->

    person.validate()

    assert.equal get(person, "_errors.name"), ""
    assert.equal get(person, "_isValid"), false

    set person, "name", "Yehuda"
    person.validate()

    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_isValid"), true
