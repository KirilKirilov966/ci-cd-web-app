# Use an official Node.js image as the base image
FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy all project files to the container
COPY . .

# Expose port 4000 to the host
EXPOSE 4000

# Start the app
CMD ["node", "server.js"]
