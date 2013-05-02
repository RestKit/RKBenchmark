# RestKit Benchmarking

This application provides a simple benchmarking environment for analyzing RestKit performance. When launched, the application will run through a number of scenarios that exercise the RestKit Core Data object mapping layer in various scenarios. At present writing, the benchmarks are exclusively focused on mapping performance and do not exercise the network layer at all.

## Setup and Installation

This application includes two parts:

1. Simple Ruby Rake tasks for generating testing data.
1. An iOS application for running the benchmarks.

To configure both environments, simply do the following:

1. Checkout the RestKit submodule: `git submodule update --init`
1. Install Bundler for Ruby and bundle the dependencies: `gem install bundler && bundle`
1. Use CocoaPods to bind the dependencies into the app: `pod install`
1. Open `RKBenchmark.xcworkspace` and select the 'Product' menu > 'Run...'

When the application executes, it will emit logging information about the execution time of the various scenarios. The scenarios are defined and executed with the `RKBAppDelegate.m` file for simplicity.

## Accuracy and Measurement Practices

Just executing these benchmarks standalone is only sufficient for measuring the order of magnitude impact of changes. For example, given two revisions with a known performance regression you can easily use Git bisect within the submodule and execute the benchmarks to find the source of the regression.

If you are attempting to measure the overall performance impact of one of more changes, you will need to run the benchmarks repeatedly on an unloaded machine and average the results. It can be useful to modify the output emitted or add loops to the scenarios as appropriate. Consider this application a starting point for benchmarking, not a complete solution unto itself. You need to make sure are modeling your scenarios and measuring for statistical significance.
