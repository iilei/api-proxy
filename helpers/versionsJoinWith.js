var versionsJoinWith = function () {};

versionsJoinWith.register = function (Handlebars) {
    Handlebars.registerHelper('versionsJoinWith', function(upstreams, delim, block) {
        return Object.keys(upstreams)
          .map(v => v.replace(/^v/i, ''))
          .join(delim || '|');
    });
};

module.exports = versionsJoinWith;
