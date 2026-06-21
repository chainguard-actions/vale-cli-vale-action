# `jdkato/vale` installs Vale to `/bin/vale`.
FROM jdkato/vale:v2.15.5

RUN apk add --no-cache --update nodejs nodejs-npm git openjdk11 libxslt

COPY lib /lib
COPY package.json /package.json

RUN npm install --production

ENV REVIEWDOG_VERSION=v0.14.1
# Download install script from a pinned commit (v0.14.1) instead of mutable master,
# save to a file, then execute separately — never pipe remote scripts directly to sh.
RUN wget -q -O /tmp/install-reviewdog.sh https://raw.githubusercontent.com/reviewdog/reviewdog/24525080d62b75fd8d589f447e22b0c615713f04/install.sh \
    && sh /tmp/install-reviewdog.sh -b bin ${REVIEWDOG_VERSION} \
    && rm /tmp/install-reviewdog.sh

RUN wget https://github.com/dita-ot/dita-ot/releases/download/3.6/dita-ot-3.6.zip
RUN unzip dita-ot-3.6.zip > /dev/null 2>&1

ENV PATH="/dita-ot-3.6/bin:${PATH}"

ENTRYPOINT ["node", "/lib/main.js"]
