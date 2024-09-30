FROM cypress/base:20.17.0

WORKDIR /app
COPY package*.json ./
RUN yarn install

COPY . .

# Set environment variables for Cypress
# ENV CYPRESS_CACHE_FOLDER=/root/.cache/Cypress

# Command to start Vite and run Cypress tests
CMD ["/app/run_tests.sh"]
