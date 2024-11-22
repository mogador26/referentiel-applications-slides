FROM node:18 AS builder


ARG http_proxy
ARG https_proxy
ARG npm_registry
ARG no_proxy

# ENV NODE_ENV production

# Create app directory

WORKDIR /usr/src/app

# use proxy & private npm registry
# With internal npm repo (autosigned) disable strict ssl : strict-ssl false
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo "Europe/Paris" > /etc/timezone ; \
    if [ ! -z "$http_proxy" ] ; then \
    npm config delete proxy; \
    npm config set proxy $http_proxy; \
    npm config set https-proxy $https_proxy ; \
    npm config set no-proxy $no_proxy; \
    fi ; \
    [ -z "$npm_registry" ] || npm config set registry=$npm_registry ; \
    [ -z "$npm_registry" ] || npm config set strict-ssl false

RUN npm cache clean -force

# copy all dependances
COPY package.json .

# copy all source files into app workdir
COPY . .

# install dependencies
RUN npm install
RUN echo "installation"

# build
RUN npm run build

FROM nginxinc/nginx-unprivileged

WORKDIR /usr/share/nginx/html/

COPY --from=builder /usr/src/app/dist ./

ENTRYPOINT ["nginx", "-g", "daemon off;"]
