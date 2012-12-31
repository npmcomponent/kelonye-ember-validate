Ember Validate [![Build Status](https://secure.travis-ci.org/kelonye/ember-validate.png?branch=master)](http://travis-ci.org/kelonye/ember-validate)
===

Validate ember objects.

Goals
---

* Custom error messages
* Multiple validators per property

Install
---
```
component install kelonye/ember-validate
```

Usage
---

Available validators

* Presence
* Email
* Regex
* Numericality
* <, >, <= and >=

Example
---

Example shows the 3 ways to pass validator options.

```
  App.Person = Em.Object.extend require('ember-validate'),
    validations:
      name: 'presence' # validate against presence validator
      tel:
        presence: true
        min: 9
        max:
          max: 13
          equal: true
        re:
          msg: "Invalid phone number format" # custom error message
          re: /^(?:0|\+?254)7\d{8}$/
      email: "email"
  person = Person.create()
  person.validate()
  errors  = get person, "_errors"
  isValid = get person, "_isValid"

  errors.get 'name'
  ...
```

Testing
---

```
npm install && component install && make
```