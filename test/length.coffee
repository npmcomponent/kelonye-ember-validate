get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe 'Length:', ->

  beforeEach ->

    Person = Em.Object.extend ValidateMixin,
      validations:
        books: [
          length: '@<10' 
        ]

    person = Person.create()

  afterEach ->
    person = null

  it 'books length is out of range', ->
    set person, 'books', [0..18]
    person.validate()

    assert.equal get(person, '_errors.books'), '¬ !length: 19<10'
    assert.equal get(person, '_isValid'), false

  it 'books length is ok', ->
    set person, 'books', [0..5]
    person.validate()

    assert.equal get(person, '_errors.books'), undefined
    assert.equal get(person, '_isValid'), true
    