FROM cypress/base:20.17.0

WORKDIR /app
COPY package*.json ./
RUN yarn install && \
    rm -rf /usr/local/share/.cache/yarn

COPY . .

# Command to start Vite and run Cypress tests
CMD ["/app/run_tests.sh"]
