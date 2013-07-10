var Person;
var person;

describe('compr:', function() {
  beforeEach(function() {
    Person = Em.Object.extend(ValidateMixin, {
      validations: {
        age: [
          {
            compr: '@<10'
          }
        ]
      }
    });
    person = Person.create();
  });
  afterEach(function() {
    person = null;
  });
  it('age is out of range', function() {
    person.set('age', 20);
    person.validate();
    assert.equal(person.get('_errors.age'), '¬ !comparison: 20<10');
    assert.equal(person.get('_isValid'), false);
  });
  it('age is ok', function() {
    person.set('age', 5);
    person.validate();
    assert.equal(person.get('_errors.age'), undefined);
    assert.equal(person.get('_isValid'), true);
  });
});
