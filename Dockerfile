FROM cypress/base:20.17.0

WORKDIR /app
COPY package*.json ./
RUN yarn install

# Clear /usr/local/share/.cache/yarn ~ 419 MB
# Clear /root/.cache/Cypress ~ 610 MB

COPY . .

# Command to start Vite and run Cypress tests
CMD ["/app/run_tests.sh"]
