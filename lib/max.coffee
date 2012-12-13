Em = window.Em

get = Em.get
set = Em.set

module.exports = Em.Object.extend
  
  msg: "Long"
  
  validate: ->

    obj   = get @, "obj"
    attr  = get @, "attr"
    max   = get @, "max"
    equal = get @, "equal"
    val   = get obj, attr

    if equal and (val.length <= max) is false
      false
    else if val.length > max
      false