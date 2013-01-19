Ember Validate [![Build Status](https://secure.travis-ci.org/kelonye/ember-validate.png?branch=master)](http://travis-ci.org/kelonye/ember-validate)
===

Validate ember objects.

Install
---

```
component install kelonye/ember-validate
```

Features
---

* Custom error messages
* Multiple validators per property

Validators
---

* Presence
* Email
* Regex
* Length
* Comparison

Example
---

javascript

```
  App.Person = Em.Object.extend require('ember-validate'),

    validations:

      age: [

        'presence'                  # presence

        length: '@<3'               # length
        length: '@>3'
        length: '@<=3'
        length: '@>=3'

        compr: '@<3'                # comparison
        compr: '@>3'
        compr: '@<=3'
        compr: '@>=3'

        (obj, attr, options)->      # function
          _options = options
          if options isnt _options
            false

        [/\d+/, 'error msg']           # validators with custom error msg
        ['presence', '¬ required']
        [
          (obj, attr, options)->
          '¬ error'
        ]

        ...

      ]

  person = Person.create()
  person.validate()
  errors  = get person, "_errors"
  isValid = get person, "_isValid"

  errors.get 'name'
  ...

```

Requiring this also adds a .error class binding to Em.Textfield and Em.Textarea

Testing
---

```
npm install && component install && make
```