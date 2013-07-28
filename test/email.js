var Person;
var person;

describe('email:', function() {
  beforeEach(function() {
    Person = Em.Object.extend(ValidateMixin, {
      validations: {
        email: ['presence', 'email']
      }
    });
    person = Person.create({
      email: 'g'
    });
  });
  afterEach(function() {
    person = null;
  });
  it('email is absent', function() {
    person.validate(function(){
      assert.equal(person.get('_errors.email'), '¬ wrong email format');
      assert.equal(person.get('_isValid'), false);
    });
  });
  it('email format is wrong', function() {
    person.set('email', 'jc.c');
    person.validate(function(){
      assert.equal(person.get('_errors.email'), '¬ wrong email format');
      assert.equal(person.get('_isValid'), false);
    });
  });
  it('email is ok', function() {
    person.set('email', 'j@c.c');
    person.validate(function(){
      assert.equal(person.get('_errors.email'), undefined);
      assert.equal(person.get('_isValid'), true);
    });
  });
});
