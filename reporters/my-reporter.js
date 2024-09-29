const { reporters } = require('mocha');

class MyReporter extends reporters.Base {
  constructor(runner) {
    super(runner);

    runner.on('start', () => {
      console.log('Test Suite Started');
    });

    runner.on('pass', (test) => {
      console.log(`Test Passed: ${test.title}`);
    });

    runner.on('fail', (test, err) => {
      console.log(`Test Failed: ${test.title} - ${err.message}`);
    });

    runner.on('end', () => {
      console.log('Test Suite Ended');
    });
  }
}

module.exports = MyReporter;
