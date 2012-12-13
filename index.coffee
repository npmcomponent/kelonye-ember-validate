Em = window.Em

get = Em.get
set = Em.set

module.exports = Em.Mixin.create
  
  # registers validators
  validators: 
    presence: require './lib/presence'
    max: require './lib/max'
    min: require './lib/min'
    re: require './lib/re'
    email: require './lib/email'
    num: require './lib/num'

  init: ->

    @_super()

    that = @
    validations = get @, "validations"

    set @, "_errors", Em.Object.create()

    for attr, validator of validations

      set that, "_errors.#{attr}",
        msg: undefined
        isValid: true

  # recreates validations
  validate: ->

    that = @
    validators = get @, "validators"

    set @, "_isValid", true

    validate = (validator, options)->

      if options.constructor.name isnt "Object"

        # isnt a hash
        _options = options
        options = {}
        options[validator] = _options

      options["obj"] = that
      options["attr"] = attr

      validator = validators[validator].create options 
      isValid = if validator.validate() is false then false else true
      msg = if isValid then undefined else get validator, "msg"

      set that, "_errors.#{attr}",
        msg: msg
        _isValid: isValid

      isValid

    for attr, validations of get @, "validations"

      if typeof validations is "string"
        validator = validations
        isValid = validate validator, {}
        if isValid is false
          set that, "_isValid", false
          break

      else

        for validator, options of validations
          
          isValid = validate validator, options
          if isValid is false
            set that, "_isValid", false
            break