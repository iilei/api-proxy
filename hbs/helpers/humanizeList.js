const humanize = require('humanize-list');

const humanizeList = function () {};

humanizeList.register = function (Handlebars) {
  Handlebars.registerHelper('humanizeList', function(list, conjunction) {
    const array = Array.isArray(list) ? list : Object.keys(list);
    return humanize(array, { conjunction });
  });
};

module.exports = humanizeList;
