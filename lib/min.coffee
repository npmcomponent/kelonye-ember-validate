Em = window.Em

get = Em.get
set = Em.set

module.exports = Em.Object.extend 
  
  msg: "Short"
  
  validate: ->

    obj   = get @, "obj"
    attr  = get @, "attr"
    min   = get @, "min"
    equal = get @, "equal"
    val   = get obj, attr
    
    if equal and (val.length >= min) is false
      false
    else if val.length < min
      false
