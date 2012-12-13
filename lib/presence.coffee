Em = window.Em

get = Em.get
set = Em.set

module.exports = Em.Object.extend
  
  msg: ""
  
  validate: ->
    obj   = get @, "obj"
    attr  = get @, "attr"
    val   = get obj, attr
    if not (val and val.match /^.+$/mi)
      false
