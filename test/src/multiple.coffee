get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "multiple:", ->

  beforeEach ->

    Person = Em.Object.extend ValidateMixin,
      validations:
        name: ["presence"]
        tel: [
          (obj, attr, options)->
            if not get obj, "#{attr}"
              false
          [/^(?:0|\+?254)7\d{8}$/, 'cell no. is invalid']
        ]
    person = Person.create()

  afterEach ->
    person = null

  it "name absent", ->

    person.validate()

    assert.equal get(person, "_errors.name"), ""
    assert.equal get(person, "_errors.tel"), undefined #not applied yet
    assert.equal get(person, "_isValid"), false

  it "tel absent", ->

    set person, "name", "TJ"
    person.validate()

    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_errors.tel"), ''
    assert.equal get(person, "_isValid"), false

  it "tel format is wrong", ->

    set person, "name", "TJ"
    set person, "tel", "254000111222"
    person.validate()

    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_errors.tel"), "cell no. is invalid"
    assert.equal get(person, "_isValid"), false


  it "name and tel are ok", ->

    set person, "tel", "254700111222"
    set person, "name", "TJ"
    person.validate()

    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_errors.tel"), undefined
    assert.equal get(person, "_isValid"), true

