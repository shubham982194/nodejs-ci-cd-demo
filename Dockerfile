# Use an official Node.js runtime as the base image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /usr/src/app

# Copy dependency files first for better build caching
COPY package*.json ./

# Install only production dependencies
RUN npm install --production

# Copy app source code
COPY . .

# Expose the app port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]

