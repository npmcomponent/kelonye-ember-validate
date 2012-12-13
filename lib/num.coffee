Em = window.Em

get = Em.get
set = Em.set

module.exports = Em.Object.extend

  msg: "invalid"
  
  validate: ->

    obj       = get @, "obj"
    attr      = get @, "attr"
    zero      = get @, "zero"
    positive  = get @, "positive"
    negative  = get @, "negative"
    val       = parseInt(get obj, attr)

    if isNaN val
      false
    else if zero and val is 0
      true
    else if val is 0
      false
    else if positive and val < 0
      false
    else if negative and val > 0
      false
