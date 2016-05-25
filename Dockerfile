FROM mhart/alpine-node:0.10.40
MAINTAINER butlerx <butlerx@redbrick.dcu.ie.com>

RUN apk add --update  git make gcc g++ python postgresql-client

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install --production
COPY *.js /usr/src/app/

RUN node /usr/src/app/localdev.js init zen
RUN node /usr/src/app/localdev.js testdata zen

EXPOSE 5432
EXPOSE 8000

RUN apk del make gcc g++ python && rm -rf /tmp/* /root/.npm /root/.node-gyp

CMD ["node", "localdev.js run zen"]
