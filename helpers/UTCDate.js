var UTCDate = function () {};

UTCDate.register = function (Handlebars) {
    Handlebars.registerHelper('UTCDate', function(value, block) {
      const result = (new Date(value)).toUTCString() || "Invalid Date";
      if (result === "Invalid Date") {
        throw new Error(`Invalid Date provded: "${value}"!`);
      }
      // toUTCString ~= RFC 1123 - in respect to HTTP Date Header convention
      return (new Date(value)).toUTCString();
    });
};

module.exports = UTCDate;
