Em = window.Em

get = Em.get
set = Em.set

module.exports = (obj, attr, options)->
  val  = get obj, attr
  expr = options.replace '@', val

  if not eval expr
    [
      false
      "¬ !comparison: #{expr}"
    ]