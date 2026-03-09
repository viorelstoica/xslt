FROM node:22-alpine
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN npm i && npm run build
CMD ["npm", "run", "preview"]