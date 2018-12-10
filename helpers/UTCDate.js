var UTCDate = function () {};

function dateExample() {
  var d = new Date();
  return `${d.getUTCFullYear()}-${d.getUTCMonth() + 1}-${d.getUTCDate()}`
}

UTCDate.register = function (Handlebars) {
    Handlebars.registerHelper('UTCDate', function(value, block) {
      const result = (new Date(value)).toUTCString() || "Invalid Date";

      if (result === "Invalid Date") {
        throw new Error([
          `Invalid Date provded: "${value}"`,
          `To generate a valid Date, generate a valid date-time:`,
          `>  node -e "console.log(new Date('${dateExample()}'))" `,
          `Or:`,
          `    ${new Date(dateExample()).toGMTString()}`,
          ].join('\n')
        );
      }

      // toUTCString ~= RFC 1123 - in respect to HTTP Date Header convention
      return (new Date(value)).toGMTString();
    });
};

module.exports = UTCDate;
