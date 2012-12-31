Em = window.Em

get = Em.get
set = Em.set

module.exports = Em.Mixin.create
  
  # 'register' validators
  validators: 
    presence: require './lib/presence'
    max:      require './lib/max'
    min:      require './lib/min'
    re:       require './lib/re'
    email:    require './lib/email'
    num:      require './lib/num'

  init: ->

    @_super()

    # set up _errors* object,
    # *named so to avoid conflicts with ember-data
    that = @
    validations = get @, "validations"
    set @, "_errors", Em.Object.create()
    for attr, validator of validations
      set that, "_errors.#{attr}", undefined

  validate: ->

    that = @
    validators = get @, "validators"

    # reset _isValid property
    # *named so to avoid conflicts with ember-data
    set @, "_isValid", true

    # fn that does actual validation
    # @param {String} fn name of a 'registred' validator
    # @param {hash} options to pass to validator fn
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

      set that, "_errors.#{attr}", msg

      isValid

    ###
    
    Validate against any* of the following formats. Examples show how options are passed depending on their requirement.
    
    1.

      name: 'presence' # no options required by validator
      
      the above is same as,

      name:
        prsence: true
      
    2.

      name:
        max: 4 # one option required
      
      same as, 
      
      name:
        max:
          max: 4

    3.
      name: 
       max:
         max: 4
         equal: true #optional param
    ###


    for attr, validations of get @, "validations"

      if typeof validations is "string"
        # format 1
        validator = validations
        isValid = validate validator, {}

        if isValid is false
          set that, "_isValid", false
          break

      else

        for validator, options of validations
          # format 2, 3
          isValid = validate validator, options
          if isValid is false
            set that, "_isValid", false
            break