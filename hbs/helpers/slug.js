const slugify = require('@sindresorhus/slugify');

var slug = function () {};

slug.register = function (Handlebars) {
    Handlebars.registerHelper('slug', function(value, block) {
        return slugify(value, {separator: '_'})
    });
};

module.exports = slug;
