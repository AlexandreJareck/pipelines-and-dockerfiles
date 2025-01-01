# Build stage
FROM node:18-alpine as build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build -- --configuration=production

# Production stage
FROM nginx:alpine

COPY --from=build /usr/src/app/dist/project-frontend/browser /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 4000

CMD ["nginx", "-g", "daemon off;"]