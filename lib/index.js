/**
  * Module dependencies
  */
require('ember');


/**
  * Regex expressions
  */
var REGEX_EXPRS = Em.Object.create({
  // presence: [/^.+$/mi, ''],
  email: [/.+@.+\..+/, '¬ wrong email format']
});


/**
  * Validator
  */ 

var Validator = Em.Object.extend({
  init: function(){
    this._super();
    var options = {};
    var validation = this.get('validation');
    if (validation instanceof Array) {
      var tmp = validation;
      validation = tmp[0];
      this.set('error', tmp[1]);
    }
    if (typeof validation === 'string') {
      fn = validation;
      _options = REGEX_EXPRS.get(fn);
      if (_options) {
        fn = 're';
        var tmp = _options;
        options = tmp[0];
        if (!this.get('error')){
          this.set('error', tmp[1]);
        }
      }
    } else if (validation instanceof RegExp) {
      fn = 're';
      options = validation;
    } else if (typeof validation === 'function') {
      fn = validation;
    } else {
      keys = Object.keys(validation);
      fn = keys[0];
      options = validation[fn];
    }
    if (typeof fn === 'string') {
      fn = require('./validators/' + fn);
    }
    this.set('fn', fn);
    this.set('options', options);
  },
  validate: function(obj){
    var fn = this.get('fn');
    var options = this.get('options');
    var attr = this.get('attr');
    var isValid = true;
    var error = '';
    // console.log(fn);
    // console.log(options);
    // console.log(attr);
    // console.log(obj);
    //
    var result = fn(obj, attr, options);
    if (result instanceof Array) {
      isValid = result[0];
      error = result[1];
      // console.log(isValid);
      // console.log(error);
    } else {
      isValid = result;
      // console.log(isValid);
    }
    //
    if (isValid == undefined){
      isValid = true;
    }
    if (isValid == true) {
      error = undefined;
    } else {
      if (this.get('error')){
        error = this.get('error');
      }
    }
    // console.log(isValid);
    // console.log(error);
    obj.set('_isValid', isValid);
    obj.set('_errors.' + attr, error);
  }
});

/**
  * Mixin
  */
module.exports = Em.Mixin.create({

  _isValid: true,
  
  _errors: {},
  
  /**
    * Generate 
    * [
    *   { attr: [{fn: obj, options: {}, error: '' }, ...]}, ...
    * ]
    *
    */
  init: function(){
    var that = this;
    this._super();
    var _validations = [];
    for (var attr in that.get('validations')) {
      var _validators = [];
      that.get('validations')[attr].forEach(function(validation){
        var _validator = Validator.create({
          attr: attr,
          validation: validation
        });
        _validators.push(_validator);
      });
      var _validation = {};
      _validation.attr = attr;
      _validation.validators = _validators;
      _validations.push(_validation);
    }
    this.set('_validations', _validations);
  },


  validate: function(){
    var that = this;
    var validations = that.get('_validations');
    var i=0;
    while(validations[i]){
      (function(i){
        var validation = validations[i];
        var attr = validation.attr;
        var validators = validation.validators;
        var j=0;
        while(validators[j]){
          (function(j){
            var validator = validators[j];
            validator.validate(that);
          })(j);
          j++;
          if (that.get('_isValid') == false){
            break;
          }
        }
      })(i);
      i++;
      if (that.get('_isValid') == false){
        break;
      }
    }
  }
});