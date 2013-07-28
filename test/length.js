var Person;
var person;

describe('Length:', function() {
  beforeEach(function() {
    Person = Em.Object.extend(ValidateMixin, {
      validations: {
        books: [
          {
            length: '@<10'
          }
        ]
      }
    });
    person = Person.create();
  });
  afterEach(function() {
    person = null;
  });
  it('books length is out of range', function() {
    person.set('books', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]);
    person.validate({
      assert.equal(person.get('_errors.books'), '¬ !length: 19<10');
      assert.equal(person.get('_isValid'), false);
    });
  });
  it('books length is ok', function() {
    person.set('books', [0, 1, 2, 3, 4, 5]);
    person.validate(function(){
      assert.equal(person.get('_errors.books'), undefined);
      assert.equal(person.get('_isValid'), true);
    });
  });
});
