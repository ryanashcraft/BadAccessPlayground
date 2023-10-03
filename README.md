# BadAccessPlayground

I'm trying to understand why this unit test (often) produces EXC_BAD_ACCESS errors. Is this code to blame? Is it doing something unsafe?

I have attempted to simplify this to a somewhat-minimal example. It uses a combination of Swift actors, NSCache, Combine, and XCTest.

Notes:
- Malloc scribble, malloc guard edges, guard malloc, zombie objects, and malloc stack logging are enabled in the test plan.
- The caching logic inside the Store actor is based off of this Apple tutorial: https://developer.apple.com/tutorials/app-dev-training/caching-network-data.
- The code is weird, yes. It is not optimized for readability; it's written to maximize the likelihood of an error.

## Instructions

1. Open BadAccessPlayground.xcodeproj in Xcode 15
2. Run the testBadAccess() test in BadAccessPlaygroundTests.swift
3. Repeat. If you do not witness any EXC_BAD_ACCESS errors, try adjusting loopCount and/or maxItemCount and running on another device

## Screenshots

![Screenshot of Xcode with an EXC_BAD_ACCESS inside the NSCache extension](/screenshots/1.png)

![Screenshot of Xcode with an EXC_BAD_ACCESS inside the test case](/screenshots/2.png)