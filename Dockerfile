# Use the official Node.js 14 Alpine image as a parent image
FROM node:14-alpine

# Set the working directory in the Docker container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (or yarn.lock) files into the container
COPY package*.json ./

# Install dependencies
# Add 'python', 'make', and 'g++' if you have native dependencies
RUN apk add --no-cache --virtual .gyp python3 make g++ && \
    npm install && \
    apk del .gyp

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Expose the port the app runs on
EXPOSE 5000

# Command to run the application
CMD ["node", "dist/main"]
