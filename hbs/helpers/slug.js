const slugify = require('@sindresorhus/slugify');

const slug = function () {};

slug.register = function (Handlebars) {
    Handlebars.registerHelper('slug', function(value) {
        return slugify(value, {separator: '_'})
    });
};

module.exports = slug;
