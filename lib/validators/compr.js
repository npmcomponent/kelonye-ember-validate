var Em = window.Em;

module.exports = function(obj, attr, options, done) {
  var val = obj.get(attr);
  var expr = options.replace('@', val);
  if (!eval(expr)) {
    return done('¬ !comparison: ' + expr);
  }
  done();
};
