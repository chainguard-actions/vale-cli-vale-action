# `jdkato/vale` installs Vale to `/bin/vale`.
FROM jdkato/vale:v2.15.5@sha256:04fa3670428d88a253436829a687c26bfb8ca1b595afaae1242852c4a9a0b44a

RUN apk add --no-cache --update nodejs nodejs-npm git openjdk11 libxslt

COPY lib /lib
COPY package.json /package.json

RUN npm install --production

# Download reviewdog from a pinned release tarball instead of piping from a mutable branch
ENV REVIEWDOG_VERSION=v0.14.1
RUN wget -q -O /tmp/reviewdog.tar.gz \
      "https://github.com/reviewdog/reviewdog/releases/download/${REVIEWDOG_VERSION}/reviewdog_${REVIEWDOG_VERSION#v}_Linux_x86_64.tar.gz" \
    && tar -xzf /tmp/reviewdog.tar.gz -C bin reviewdog \
    && rm /tmp/reviewdog.tar.gz

RUN wget https://github.com/dita-ot/dita-ot/releases/download/3.6/dita-ot-3.6.zip
RUN unzip dita-ot-3.6.zip > /dev/null 2>&1

ENV PATH="/dita-ot-3.6/bin:${PATH}"

ENTRYPOINT ["node", "/lib/main.js"]
