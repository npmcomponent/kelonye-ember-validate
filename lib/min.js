// Generated by CoffeeScript 1.4.0
var Em, get, set;

Em = window.Em;

get = Em.get;

set = Em.set;

module.exports = Em.Object.extend({
  msg: "Short",
  validate: function() {
    var attr, equal, min, obj, val;
    obj = get(this, "obj");
    attr = get(this, "attr");
    min = get(this, "min");
    equal = get(this, "equal");
    val = get(obj, attr);
    if (equal && (val.length >= min) === false) {
      return false;
    } else if (val.length < min) {
      return false;
    }
  }
});