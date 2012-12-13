Em = window.Em

get = Em.get
set = Em.set

module.exports = Em.Object.extend
  
  msg: (->

    obj  = get @, "obj"
    attr = get @, "attr"
    re   = get @, "re"
    val  = get obj, attr
    "#{val} doesn't match #{re}"
  
  ).property "re"
  
  validate: ->
    
    obj  = get @, "obj"
    attr = get @, "attr"
    re   = get @, "re"
    val  = get obj, attr
    
    if not (val.match re)
      false
