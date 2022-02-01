### STAGE 1: Build ###
FROM node:14.16.0-alpine as build


# # Create app directory
# RUN mkdir -p /usr/src/app
# WORKDIR /usr/src/app

# # Install app dependencies
# COPY eks/package.json /usr/src/app/
# #COPY yarn.lock /usr/src/app/
# RUN yarn install

# # Set environment variables
# ENV NODE_ENV production
# ENV NUXT_HOST 0.0.0.0
# ENV NUXT_PORT 80

# # Bundle app source
# COPY eks/* /usr/src/app
# RUN yarn build

# # Clear the cache
# RUN yarn cache clean

EXPOSE 80
CMD [ "yarn", "start" ]