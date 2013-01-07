Em = window.Em
get = Em.get
set = Em.set

# add .error class binding to text views
Em.TextSupport.reopen
  
  isValid: true
  error: undefined
  classNameBindings: ['isValid::error']

  init: ->

    @_super()

    that = @
    _for    = get @, 'for'
    context = get @, 'context'
    context.reopen

      validate: ->

        @_super()
        
        error   = get @, "_errors.#{_for}"
        isValid = error is undefined
        
        that.setProperties
          error: error
          isValid: isValid
        