Em = window.Em

get = Em.get
set = Em.set

Em.PresenceV = Em.Object.extend 
  msg: ""
  validate: (obj, attr) ->
    val = obj.get attr
    if not (val and val.match /^.+$/mi)
      false

Em.MinV = Em.Object.extend 
  msg: "Short"
  validate: (obj, attr) ->
    val = obj.get attr
    min = @get "min"
    equal = @get "equal"
    if equal and (val.length >= min) is false
      false
    else if val.length < min
      false

Em.MaxV = Em.Object.extend 
  msg: "Long"
  validate: (obj, attr) ->
    val = obj.get attr
    max = @get "max"
    equal = @get "equal"
    if equal and (val.length <= max) is false
      false
    else if val.length > max
      false

Em.RegV = Em.Object.extend
  msg: ""
  validate: (obj, attr) ->
    val = obj.get attr
    if not(val.match @get("exp"))
      false

Em.NumV = Em.Object.extend
  msg: "invalid"
  validate: (obj, attr) ->
    val = parseInt(obj.get attr)
    if isNaN val
      false
    else if @get("zero") and val is 0
      true
    else if val is 0
      false
    else if @get("positive") and val < 0
      false
    else if @get("negative") and val > 0
      false

Em.GmailV = Em.Object.extend
  msg: "invalid"
  reg: /\S+@gmail.com/

Em.V = Em.Mixin.create
  
  _errors: Em.Object.create()

  init: ->
    @_super()
    that = @
    @get("validations")?.forEach((obj) ->
      path = "_errors."+obj.on
      that.set path,
        valid: true
        msg: undefined
    )

  validate: ->
    that = @
    @get("validations").forEach((obj) ->
      attr = obj.on
      validator = obj.validators.find((validator) ->
        true if validator.validate(that, attr) is false
      )
      if validator
        msg = validator.get("msg")
        valid = false
      else
        msg = undefined
        valid = true
      path = "_errors."+attr
      that.set path,
        valid: valid
        msg: msg
    )

  _isValid: (->
    _errors = @get "_errors"
    if _errors
      validator = @get("validations").find((obj) ->
        attr = obj.on
        !!!_errors.get(attr+".valid")
      )
      if validator
        false
      else
        true
    else
      true 
  ).property("_errors@each.valid").volatile()
