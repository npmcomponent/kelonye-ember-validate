get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "multiple:", ->

  beforeEach ->

    Person = Em.Object.extend ValidateMixin,
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
            msg: "Number, invalid" 
            re: /^(?:0|\+?254)7\d{8}$/
    person = Person.create()

  afterEach ->
    person = null

  it "name and tel, absent", ->

    person.validate()

    assert.equal get(person, "_errors.name"), ""
    assert.equal get(person, "_errors.tel"), undefined #applied yet
    assert.equal get(person, "_isValid"), false

  it "tel, too short", ->

    set person, "name", "TJ"
    set person, "tel", "2547"
    person.validate()

    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_errors.tel"), "Short"
    assert.equal get(person, "_isValid"), false

  it "tel, too long", ->

    set person, "name", "TJ"
    set person, "tel", "2547001110001111"
    person.validate()

    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_errors.tel"), "Long"
    assert.equal get(person, "_isValid"), false

  it "tel format, wrong", ->

    set person, "name", "TJ"
    set person, "tel", "254000111222"
    person.validate()

    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_errors.tel"), "Number, invalid"
    assert.equal get(person, "_isValid"), false


  it "name and tel are ok", ->

    set person, "tel", "254700111222"
    person.validate()

    assert.equal get(person, "_errors.name"), ""
    assert.equal get(person, "_errors.tel"), undefined
    assert.equal get(person, "_isValid"), false

    set person, "name", "TJ"
    person.validate()

    assert.equal get(person, "_errors.name"), undefined
    assert.equal get(person, "_errors.tel"), undefined
    assert.equal get(person, "_isValid"), true

