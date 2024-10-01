FROM cypress/base:20.17.0

WORKDIR /app
COPY package*.json ./
RUN yarn install

COPY . .

# Command to start Vite and run Cypress tests
CMD ["/app/run_tests.sh"]
