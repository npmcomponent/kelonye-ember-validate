var Em = window.Em;

module.exports = function(obj, attr, options, done) {
  var val = obj.get(attr);
  if (Em.$.trim(val) === '') {
    return done(' ');
  }
  done();
};
