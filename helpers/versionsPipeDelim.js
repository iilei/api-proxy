var versionsPipeDelim = function () {};

versionsPipeDelim.register = function (Handlebars) {
    Handlebars.registerHelper('versionsPipeDelim', function(upstreams, block) {
        return Object.keys(upstreams)
          .map(v => v.replace(/^v/i, ''))
          .join('|');
    });
};

module.exports = versionsPipeDelim;
