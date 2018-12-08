FROM subfuzion/envtpl:latest as services

RUN apk update \
    && apk upgrade \
    && apk add --no-cache jq py-pip bash openssl curl gnupg nodejs \
    && pip install yq \
    && rm -rf /var/cache/apk/*

RUN npm i -g "hbs-cli" "@sindresorhus/slugify"

COPY . .


# ENTRYPOINT ["/entrypoint.sh"]

# CMD ["nginx", "-g", "daemon off;"]
