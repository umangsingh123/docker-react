#This example is going to show multi step build process for docker container/docker file
# the phase is named as builder
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

#second Phase starting to spin up nginx server
FROM nginx
# copying from builder phase to NGINX server
COPY --from=builder /app/build /usr/share/nginx/html
