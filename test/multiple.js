var Person;
var person;

describe('multiple:', function() {
  beforeEach(function() {
    Person = Em.Object.extend(ValidateMixin, {
      validations: {
        name: ['presence'],
        tel: [
          function(obj, attr, options) {
            if (!obj.get(attr)) {
              return false;
            }
          }, [/^(?:0|\+?254)7\d{8}$/, 'cell no. is invalid']
        ]
      }
    });
    person = Person.create();
  });
  afterEach(function() {
    person = null;
  });
  it('name absent', function() {
    person.validate();
    assert.equal(person.get('_errors.name'), '');
    assert.equal(person.get('_errors.tel'), undefined);
    assert.equal(person.get('_isValid'), false);
  });
  it('tel absent', function() {
    person.set('name', 'TJ');
    person.validate();
    assert.equal(person.get('_errors.name'), undefined);
    assert.equal(person.get('_errors.tel'), '');
    assert.equal(person.get('_isValid'), false);
  });
  it('tel format is wrong', function() {
    person.set('name', 'TJ');
    person.set('tel', '254000111222');
    person.validate();
    assert.equal(person.get('_errors.name'), undefined);
    assert.equal(person.get('_errors.tel'), 'cell no. is invalid');
    assert.equal(person.get('_isValid'), false);
  });
  it('name and tel are ok', function() {
    person.set('tel', '254700111222');
    person.set('name', 'TJ');
    person.validate();
    assert.equal(person.get('_errors.name'), undefined);
    assert.equal(person.get('_errors.tel'), undefined);
    assert.equal(person.get('_isValid'), true);
  });
});
