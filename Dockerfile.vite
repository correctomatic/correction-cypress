# Step 1: Build the Vite application
FROM node:22-alpine AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Vite project
RUN npm run build

# Step 2: Run the application and Cypress tests
FROM node:22-alpine

# Install XVFB for headless browser testing
RUN apk add --no-cache xvfb

# Set the working directory
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=build /app .

# Install Cypress separately to avoid conflicts
RUN npm install cypress

# Set environment variables for Cypress
ENV CYPRESS_CACHE_FOLDER=/root/.cache/Cypress

# Expose the port Vite will run on
EXPOSE 3000

# Command to start Vite and run Cypress tests
CMD ["sh", "-c", "npm run dev & npx wait-on http://localhost:3000 && npx cypress run"]
