var Em = window.Em;

module.exports = function(obj, attr, options) {
  var val = obj.get(attr);
  if (Em.$.trim(val) === '') {
    return false;
  }
};
