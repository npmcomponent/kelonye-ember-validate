Ember Validate [![Build Status](https://secure.travis-ci.org/kelonye/ember-validate.png?branch=master)](http://travis-ci.org/kelonye/ember-validate)
============================

An attempt at ember data validations.

See also,

https://github.com/lcoq/ember-validations

Features
------------
* custom error messages
* multiple validators per property

Usage
------------

### Presence
```
DS.Model.extend Em.V,
    name: DS.attr "string"
    tel: DS.attr "string"
    validations: [
      {
        on: "name"
        validators: [
          Em.PresenceV.create()
        ]
      }
    ]
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
### Regex

```
person = DS.Model.extend Em.V,
  name: DS.attr "string"
  tel: DS.attr "string"
  validations: [
    {
      on: "tel"
      validators: [
        Em.RegV.create
          msg: "Number is invalid" 
          exp: /^(?:0|\+?254)7\d{8}$/
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

Then call validate

```
person.validate()

_errors = person.get "_errors"
_isValid = person.get "_isValid"
```

Testing
-----------

``` rake jasmine:headless ```