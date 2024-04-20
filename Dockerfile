# Build stage
FROM node:21-alpine as build-stage
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Production stage
FROM nginx:1.25.5-alpine-slim as prod-stage
COPY --from=build-stage /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
