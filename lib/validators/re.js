// Generated by CoffeeScript 1.4.0
var Em, get, set;

Em = window.Em;

get = Em.get;

set = Em.set;

module.exports = function(obj, attr, options) {
  var re, val;
  re = options;
  val = get(obj, attr);
  if (!(val && val.match(re))) {
    return [false, "" + val + " doesn't match " + re];
  }
};