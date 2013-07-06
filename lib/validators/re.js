var Em = window.Em;

module.exports = function(obj, attr, options) {
  var re = options;
  var val = obj.get(attr);
  if (!(val && val.match(re))) {
    return [false, val + ' does not match ' + re];
  }
};
