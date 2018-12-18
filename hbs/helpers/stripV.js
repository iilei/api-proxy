var stripV = function () {};

stripV.register = function (Handlebars) {
    Handlebars.registerHelper('stripV', function(value, block) {
        return (value.replace(/^v/i, ''))
    });
};

module.exports = stripV;
