const { reporters } = require('mocha')

function safeStringify(obj, spaces=2) {
  const cache = new WeakSet()
  return JSON.stringify(obj, (key, value) => {
    if (typeof value === 'object' && value !== null) {
      if (cache.has(value)) {
        return // Circular reference found, discard key
      }
      cache.add(value)
    }
    return value
  }, spaces)
}

/*
title: test actual
parent.title: describe actual

*/

class MyReporter extends reporters.Base {
  constructor(runner) {
    super(runner)

    runner.on('start', () => {
      console.log('Test Suite Started')
    })

    runner.on('pass', (test) => {
      console.log(`Test Passed: ${test.title}`)
      console.log(safeStringify(test))
      console.log('-----------------------------------')
    })

    runner.on('fail', (test, err) => {
      console.log(`Test Failed: ${test.title} - ${err.message}`)
      console.log(safeStringify(test))
      console.log(safeStringify(err))
      console.log('-----------------------------------')
    })

    runner.on('end', () => {
      console.log('Test Suite Ended')
    })
  }
}

module.exports = MyReporter
