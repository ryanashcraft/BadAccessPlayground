# BadAccessPlayground

I'm trying to understand why this unit test (often) produces EXC_BAD_ACCESS errors. Is the code doing something unsafe? Take a look at [CombineTests.swift](/BadAccessPlaygroundTests/CombineTests.swift).

## Instructions

1. Open BadAccessPlayground.xcodeproj in Xcode 15
2. Run the testBadAccess() test in CombineTests.swift [repeatedly until failure](https://www.avanderlee.com/debugging/flaky-tests-test-repetitions/). Recommended 10000+ max iterations.
3. Repeat until you witness a EXC_BAD_ACCESS error

## Additional Tests

- See the simplified test case testBadAccessSimplified(), which removes the usage of the Store class and managing cancellable handlers.
- See testBadAccess() in OpenCombineTests.swift, which uses [OpenCombine](https://github.com/OpenCombine/OpenCombine) instead of Apple's Combine. A EXC_BAD_ACCESS error can also be observed.
- See testNoBadAccess() in PromisesTests.swift, which uses [Promises](https://github.com/google/promises) to implement a similar test case. This test does not seem to exhibit a EXC_BAD_ACCESS error.

## Screenshots

![Screenshot of Xcode with an EXC_BAD_ACCESS from running testBadAccess in CombineTests](/screenshots/combine.png)
![Screenshot of Xcode with an EXC_BAD_ACCESS from running testBadAccess in OpenCombineTests](/screenshots/opencombine.png)
