# BadAccessPlayground

I'm trying to understand why this unit test (often) produces EXC_BAD_ACCESS errors. Is the code doing something unsafe? Take a look at [BadAccessPlaygroundTests.swift](/BadAccessPlaygroundTests/BadAccessPlaygroundTests.swift).

## Instructions

1. Open BadAccessPlayground.xcodeproj in Xcode 15
2. Run the testBadAccess() test in BadAccessPlaygroundTests.swift [repeatedly until failure](https://www.avanderlee.com/debugging/flaky-tests-test-repetitions/). Recommended 10000 max iterations.
3. Repeat until you witness a EXC_BAD_ACCESS error

## Screenshots

![Screenshot of Xcode with a breakpoint unexpectedly hitting Item's deinit](/screenshots/1.png)
![Screenshot of Xcode with an EXC_BAD_ACCESS](/screenshots/2.png)
