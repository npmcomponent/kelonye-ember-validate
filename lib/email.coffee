Em = window.Em

get = Em.get
set = Em.set

module.exports = require("./re").extend
  msg: "Wrong email format"
  re: /.+@.+\..+/