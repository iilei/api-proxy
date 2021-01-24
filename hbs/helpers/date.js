var DateHelper = function () {};

DateHelper.register = function (Handlebars) {
    Handlebars.registerHelper('date', function(value, block) {
      // toGMTString ~= RFC 1123 - in respect to HTTP Date Header convention
      const result = (new Date(value)).toGMTString() || "Invalid Date";

      if (result === "Invalid Date") {
        throw new Error([
          `Invalid Date provded: "${value}"`,
          `To generate a valid Date:`,
          `>  node -e "console.log(new Date('${(new Date()).toGMTString()}').toGMTString())" `,
          `Or:`,
          `    ${new Date().toGMTString()}`,
          ].join('\n')
        );
      };
      return result;
    });
};

module.exports = DateHelper;
