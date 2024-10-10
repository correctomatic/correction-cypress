const Mocha = require('mocha')
const { reporters } = Mocha
const {
  EVENT_SUITE_BEGIN,
  EVENT_SUITE_END,
  EVENT_RUN_BEGIN,
  EVENT_RUN_END,
  EVENT_TEST_FAIL
} = Mocha.Runner.constants

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
EVENT_HOOK_BEGIN: 'hook',
EVENT_HOOK_END: 'hook end',
EVENT_RUN_BEGIN: 'start',
EVENT_DELAY_BEGIN: 'waiting',
EVENT_DELAY_END: 'ready',
EVENT_RUN_END: 'end',
EVENT_SUITE_BEGIN: 'suite',
EVENT_SUITE_END: 'suite end',
EVENT_TEST_BEGIN: 'test',
EVENT_TEST_END: 'test end',
EVENT_TEST_FAIL: 'fail',
EVENT_TEST_PASS: 'pass',
EVENT_TEST_PENDING: 'pending',
EVENT_TEST_RETRY: 'retry'
*/

/*
title: test actual
parent.title: describe actual
*/

class MyReporter extends reporters.Base {
  constructor(runner) {
    super(runner)

    // runner.on(EVENT_SUITE_BEGIN, () => {
    //   console.log('----------suite STARTED----------')
    // })

    // runner.on(EVENT_SUITE_END, () => {
    //   console.log('----------suite FINISHED----------')
    // })

    // runner.on(EVENT_RUN_BEGIN, () => {
    //   console.log('----------TESTS STARTED----------')
    // })

    runner.on(EVENT_TEST_FAIL, (test, _err) => {
      console.log(`- ${test.title}`)
    })

    // runner.once(EVENT_RUN_END, () => {
    //   this.suitCount--
    //   if(this.suitCount === 0) {
    //     console.log('----------TESTS FINISHED banana----------')
    //   }
    // })
  }
}

module.exports = MyReporter
