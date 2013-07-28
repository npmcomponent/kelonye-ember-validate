var Em = window.Em;

module.exports = function(obj, attr, options, done) {
  var re = options;
  var val = obj.get(attr);
  if (!(val && val.match(re))) {
    return done(val + ' does not match ' + re);
  }
  done();
};
