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

        function(obj, attr, options){    // function validator
          /** here,
            * obj is a Person instance
            * attr is 'age'
            * options is {}
            */
          if (obj.get(attr) == ''){
            return false;
          }
        },

        // you can provide custom error messages like so,
        
        [
          'presence',                    // presence
          '¬ required'
        ],

        [                               // regex
          /\d+/,
          '¬ unmatched'
        ],

        [                               // length
          length: '@<3',
          '¬ too long'
        ],

        [                               // comparison
          compr: '@<3',
          '¬ too long'
        ],

        [                               // function
          function(obj, attr, options){
            if (obj.get(attr) == ''){
              return false;
            }
          }, '¬ error'
        ]

        ...

      ],

  });

  // create person and validate
  var person = Person.create()
  person.validate();
  var errors  = person.get('_errors');
  var isValid = person.get('_isValid');

  console.log(errors.get('age'));
  ...

```

See [kelonye/ember-error-support](https://github.com/kelonye/ember-error-support) on use with text fields.

Test
---

```
make && open test/support.html
```

License
---

MIT