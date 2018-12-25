const Ajv = require('ajv');
const schema = require("./schema.json");
const data = require("/services.raw.json")

const ajv = new Ajv({
  useDefaults: true,
});

var validate = ajv.compile(schema);

if (!validate(data)) {
   process.exitCode = 1;
}

console.log(JSON.stringify(data, null, 2));
