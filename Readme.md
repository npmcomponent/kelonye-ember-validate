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

        'presence'                      # presence

        /\d+/                           # regex

        length: '@<3'                   # length
        length: '@>3'
        length: '@<=3'
        length: '@>=3'

        compr: '@<3'                    # comparison
        compr: '@>3'
        compr: '@<=3'
        compr: '@>=3'

        (obj, attr, options)->          # function validator
          _options = options
          if options isnt _options
            false

        # validators with custom error messages
        
        [
          'presence'                    # presence
          '¬ required'
        ]

        [                               # regex
          /\d+/
          '¬ unmatched'
        ]

        [                               # length
          length: '@<3'
          '¬ too long'
        ]

        [                               # comparison
          compr: '@<3'
          '¬ too long'
        ]

        [                               # function
          (obj, attr, options)->
            # obj is person
            # attr is age
            # hash is {}
          '¬ error'
        ]

        ...

      ]

  # create person and validate
  person = Person.create()
  person.validate()
  errors  = get person, "_errors"
  isValid = get person, "_isValid"

  errors.get 'age'
  ...

```

See [kelonye/ember-error-support](https://github.com/kelonye/ember-error-support) on use with text fields.

Testing
---

```
npm install && component install && make
```