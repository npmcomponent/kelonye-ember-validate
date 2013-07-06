var Em = window.Em;

module.exports = function(obj, attr, options) {
  var val = obj.get(attr);
  var expr = options.replace('@', val);
  if (!eval(expr)) {
    return [false, '¬ !comparison: ' + expr];
  }
};
