FROM node:21-alpine

ENV PORT=3000

WORKDIR /bookapp-react-js
COPY . /bookapp-react-js
RUN npm run build
EXPOSE ${PORT}
CMD ["npm", "start"]


FROM nginx:1.25.5-alpine-slim as prod-stage
COPY --from=build-stage /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
