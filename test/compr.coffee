get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe 'Compr:', ->

  beforeEach ->

    Person = Em.Object.extend ValidateMixin,
      validations:
        age: [
          compr: '@<10' 
        ]

    person = Person.create()

  afterEach ->
    person = null

  it 'age is out of range', ->
    set person, 'age', 20
    person.validate()

    assert.equal get(person, '_errors.age'), '¬ !comparison: 20<10'
    assert.equal get(person, '_isValid'), false

  it 'age is ok', ->
    set person, 'age', 5
    person.validate()

    assert.equal get(person, '_errors.age'), undefined
    assert.equal get(person, '_isValid'), true
    