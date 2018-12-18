var ifInKeys = function () {};

ifInKeys.register = function (Handlebars) {
  Handlebars.registerHelper('ifInKeys', function(elem, obj, options) {
    if (Object.keys(obj).includes(elem)) {
      return options.fn(this);
    }
    return options.inverse(this);
  });
};

module.exports = ifInKeys;
