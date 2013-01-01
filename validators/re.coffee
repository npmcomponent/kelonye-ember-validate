Em = window.Em
get = Em.get
set = Em.set

module.exports = (obj, attr, options)->
  re = options
  val  = get obj, attr
  if not (val and val.match re)
    [
      false
      "#{val} doesn't match #{re}"
    ]
