# The 'as' tags it for the phase this will be used in (Builder Phase)
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# This is the run phase, using a second FROM statement lets Docker know the first block is completed
# Copying from the build phase (build folder) into the NGINX directory
# NGINX has a default command to startup so no run command is needed
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
