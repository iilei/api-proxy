FROM nginx:1.15.7-alpine

COPY --from=subfuzion/envtpl:latest /usr/local/bin/envtpl /bin

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache jq py-pip bash openssl curl gnupg nodejs nodejs-npm \
    && pip install yq \
    && pip install --upgrade pip \
    && rm -rf /var/cache/apk/*

RUN npm i -g "hbs-cli@1.3.0" \
    "@sindresorhus/slugify@0.6.0" \
    "ajv@6.6.2" \
    "nginxbeautifier@1.0.18" \
    "humanize-list@1.0.1"

COPY . .

ENTRYPOINT ["/entrypoint.sh"]
