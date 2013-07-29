Install
---

```
component install kelonye/ember-validate
```

Validators
---

* Presence
* Email
* Regex
* Length
* Comparison

Example
---

```javascript

  var Person = Em.Object.extend( require('ember-validate'), {

    validations: {

      age: [

        'presence',                      // presence

        /\d+/,                           // regex

        length: '@<3',                   // length
        length: '@>3',
        length: '@<=3',
        length: '@>=3',

        compr: '@<3',                    // comparison
        compr: '@>3',
        compr: '@<=3',
        compr: '@>=3',

        function(obj, attr, options, done){    // function validator
          /** here,
            * obj is a Person instance
            * attr is 'age'
            * options is {}
            */
          if (obj.get(attr) == ''){
            return done(false);
          }
          done(true);
        },

        // you can specify custom error messages like so,
        
        [
          'presence',                    // presence
          'required'
        ],

        [                               // regex
          /\d+/,
          'unmatched'
        ],

        [                               // length
          length: '@<3',
          'too long'
        ],

        [                               // comparison
          compr: '@<3',
          'too long'
        ],

        [                               // function
          function(obj, attr, options, done){
            if (obj.get(attr) == ''){
              return done(false);
            }
            done(true);
          }, 'error'
        ]

        ...

      ],

  });

  // create person and validate
  var person = Person.create()
  person.validate(function(){
    var errors  = person.get('_errors');
    var isValid = person.get('_isValid');
    console.log(errors.get('age'));
  });

```

See [kelonye/ember-error-support](https://github.com/kelonye/ember-error-support) on use with text fields.

Test
---
  
    $ make test

License
---

MIT