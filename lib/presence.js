// Generated by CoffeeScript 1.4.0
var Em, get, set;

Em = window.Em;

get = Em.get;

set = Em.set;

module.exports = Em.Object.extend({
  msg: "",
  validate: function() {
    var attr, obj, val;
    obj = get(this, "obj");
    attr = get(this, "attr");
    val = get(obj, attr);
    if (!(val && val.match(/^.+$/mi))) {
      return false;
    }
  }
});