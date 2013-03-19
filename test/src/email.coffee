get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe 'email:', ->

  beforeEach ->

    Person = Em.Object.extend ValidateMixin,
      validations:
        email: [
          'presence'
          'email'
        ]

    person = Person.create
      email: 'g'

  afterEach ->
    person = null

  it 'email is absent', ->
    person.validate()
    assert.equal get(person, '_errors.email'), '¬ wrong email format'
    assert.equal get(person, '_isValid'), false

  it 'email format is wrong', ->
    set person, 'email', 'jc.c'
    person.validate()

    assert.equal get(person, '_errors.email'), '¬ wrong email format'
    assert.equal get(person, '_isValid'), false

  it 'email is ok', ->
    set person, 'email', 'j@c.c'
    person.validate()

    assert.equal get(person, '_errors.email'), undefined
    assert.equal get(person, '_isValid'), true
    