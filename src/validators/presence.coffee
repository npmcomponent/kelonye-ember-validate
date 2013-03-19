Em = window.Em
get = Em.get
set = Em.set

module.exports = (obj, attr, options)->
  val  = get obj, attr
  if Em.$.trim(val) is ''
    false
