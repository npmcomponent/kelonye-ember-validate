Ember Validate [![Build Status](https://secure.travis-ci.org/kelonye/ember-validate.png?branch=master)](http://travis-ci.org/kelonye/ember-validate)
=

Validate ember objects.

Goals
-

* Custom error messages
* Apply multiple validators per property

Usage
-

Available validators

* Presence
* Email
* Regex
* Numericality
* <, >, <= and >=

```
  App.Person = Em.Object.extend require("ember-validate"),
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
          msg: "Number is invalid" # custom error message
          re: /^(?:0|\+?254)7\d{8}$/
      email: "email"
  person = Person.create()
  person.validate()
  errors = person.get "_errors"
  isValid = person.get "_isValid"
```

Testing
-

``` npm install && component install && make ```