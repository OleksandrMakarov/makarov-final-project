FROM node:lts-alpine@sha256:c785e617c8d7015190c0d41af52cc69be8a16e3d9eb7cb21f0bb58bcfca14d6b

COPY --chown=node:node . /opt/app

WORKDIR /opt/app/server

RUN npm i && \
    chmod 775 -R ./node_modules/ && \
    npm run build && \
    npm prune --production && \
    mv -f dist node_modules package.json package-lock.json /tmp && \
    rm -f -R * && \
    mv -f /tmp/* . && \
    rm -f -R /tmp

ENV NODE_ENV production

EXPOSE 8000

USER node

CMD ["node", "./dist/bundle.js"]