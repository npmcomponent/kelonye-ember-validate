Ember Validate [![Build Status](https://secure.travis-ci.org/kelonye/ember-validate.png?branch=master)](http://travis-ci.org/kelonye/ember-validate)
=

Validate ember objects.

Goals
------

* Custom error messages
* Apply multiple validators per property

Usage
------

### Presence

```
person = Em.Object.create require("ember-validate"),
  name: ""
  tel: ""
  validations:
    name:
      presence: {}

```

### Email

```
person = Em.Object.create require("ember-validate"),
  email: ""
    validations:
      email:
        email: {}
```

### Regex

```
person = Em.Object.create require("ember-validate"),
  tel: ""
  validations:
    tel: 
      re:
        exp: /^(?:0|\+?254)7\d{8}$/
```


### Numericality
```
DS.Model.extend Em.V,
    name: DS.attr "string"
    tel: DS.attr "string"
    validations: [
      {
        on: "name"
        validators: [
          Em.NumV.create
            positive: true
            #negative: true
            zero: true
        ]
      }
    ]
```

### >
```
person = DS.Model.extend Em.V,
  name: DS.attr "string"
  tel: DS.attr "string"
  validations: [
    {
      on: "tel"
      validators: [
        Em.MaxV.create
          max: 3
      ]
    }
  ]
```

### <
```
person = DS.Model.extend Em.V,
  name: DS.attr "string"
  tel: DS.attr "string"
  validations: [
    {
      on: "tel"
      validators: [
        Em.MinV.create
          max: 3
      ]
    }
  ]
```

### <= / >=

Add equal=true

```
person = DS.Model.extend Em.V,
  name: DS.attr "string"
  tel: DS.attr "string"
  validations: [
    {
      on: "tel"
      validators: [
        Em.MaxV.create
          max: 3
          equal: true
      ]
    }
  ]
```

### Multiple validators

```
Person = DS.Model.extend Em.V,
    name: DS.attr "string"
    tel: DS.attr "string"
    validations: [
      {
        on: "tel"
        validators: [
          Em.PresenceV.create()
          Em.MinV.create
            min: 9
            equal: true
          Em.MaxV.create
            max: 13
            equal: true
          Em.RegV.create
            msg: "Number is invalid" 
            exp: /^(?:0|\+?254)7\d{8}$/
        ]
      }
    ]

```

### Custom
```
person = DS.Model.extend Em.V,
  name: DS.attr "string"
  tel: DS.attr "string"
  validations: [
    {
      on: "name"
      validators: [
        Em.CustomPresenceV = Em.Object.extend 
          msg: ""
          validate: (obj, attr) ->
            val = obj.get attr
            if not (val and val.match /^.+$/mi)
              false
      ]
    }
  ]
```

### Ember data
```

DS.Model = DS.Model.extend require("ember-validate"),
  name: ""
  tel: ""
  validations:
    name:
      presence: {}

```

Then call validate

```
person.validate()

errors = person.get "_errors"
isValid = person.get "_isValid"
```

Testing
-----------

``` npm install && component install && make ```