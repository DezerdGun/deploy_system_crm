###### Build #####
FROM node:24-bookworm-slim AS node
LABEL author="Harry Ho"
WORKDIR /app
COPY . .
RUN corepack enable && corepack prepare yarn@1.22.22 --activate && yarn install --frozen-lockfile --non-interactive
RUN yarn build


###### Run #####
FROM nginx:alpine
LABEL author="Harry Ho"
WORKDIR /var/cache/nginx
COPY --from=node /app/dist /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf


#########################################################
## docker build . -t  rc-prd:2.0
## docker run --publish 8080:80  --name rc2 vc-prd:2.0


