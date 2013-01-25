Em = window.Em
get = Em.get
set = Em.set

# add .error class binding to text views
Em.TextSupport.reopen
  
  isValid: true
  error: undefined
  classNameBindings: ['isValid::error']

  didInsertElement: ->

    @_super()

    that = @
    _for = get @, 'for'
    context = get @, 'context'
    
    key = "_errors.#{_for}"
    context.addObserver key, ->
      error = get context, key
      isValid = error is undefined
      that.setProperties
        error: error
        isValid: isValid

  willDestroyElement: ->
    _for = get @, 'for'
    context = get @, 'context'
    context.removeObserver "_errors.#{_for}"