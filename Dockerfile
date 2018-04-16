### STAGE 1: Build ###

FROM node:8 as builder

ARG API_URL
ENV ENV_API_URL=$API_URL

RUN mkdir /todoapp

WORKDIR /todoapp

COPY . .
RUN chmod +x start.sh
RUN ./start.sh

### STAGE 2: Setup ###

FROM nginx:1

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /usr/shate/nginx/html/*

COPY --from=builder /todoapp/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
