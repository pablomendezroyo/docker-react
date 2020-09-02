## BUILD PHASE - temporary container to generate the app in node js
FROM node:alpine as builder 
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# The folder /app/build will be created in the container with all the stuff

## RUN PHASE - new container copying the app generated in the previous step in the folder app/build
FROM nginx 
EXPOSE 80 
# EXPOSE will be found by beanstalk to expose the port
COPY --from=builder /app/build /usr/share/nginx/html 
# nginx starts automatically, it does not need a command and it uses the port 80 as the default
