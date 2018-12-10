FROM subfuzion/envtpl:latest as services

RUN apk update \
    && apk upgrade \
    && apk add --no-cache jq py-pip bash openssl curl gnupg nodejs \
    && pip install yq \
    && rm -rf /var/cache/apk/*

RUN npm i -g "hbs-cli@^1.3.0" \
    "@sindresorhus/slugify@^0.6.0" \
    "ajv-cli@^3.0.0" \
    "nginxbeautifier@1.0.18"

COPY . .


# ENTRYPOINT ["/entrypoint.sh"]

# CMD ["nginx", "-g", "daemon off;"]
