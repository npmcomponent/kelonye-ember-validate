var Person;
var person;

describe('presence:', function() {
  beforeEach(function() {
    Person = Em.Object.extend(ValidateMixin, {
      validations: {
        name: ['presence']
      }
    });
    person = Person.create({
      name: ''
    });
  });
  afterEach(function() {
    person = null;
  });
  it('name is absent', function() {
    person.validate(function(){
      assert.equal(person.get('_errors.name'), ' ');
      assert.equal(person.get('_isValid'), false);
      person.set('name', '  ');
      person.validate(function(){
        assert.equal(person.get('_errors.name'), ' ');
        assert.equal(person.get('_isValid'), false);
      });
    });
  });
  it('name is present', function() {
    person.set('name', 'Yehuda');
    person.validate(function(){
      assert.equal(person.get('_errors.name'), undefined);
      assert.equal(person.get('_isValid'), true);
    });
  });
});
