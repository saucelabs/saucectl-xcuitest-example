# saucectl XCUITest example

Example running saucectl with XCUITest.

## What You'll Need

The steps below illustrate one of the quickest ways to get set up. If you'd like a more in-depth guide, please check out
our [documentation](https://docs.saucelabs.com/dev/cli/saucectl/#installing-saucectl/).

_If you're using VS Code, you can use [Runme](https://marketplace.visualstudio.com/items?itemName=stateful.runme) to run the following commands directly from VS Code._

### Install `saucectl`

```shell
curl -L https://saucelabs.github.io/saucectl/install | bash
```

⚠ Make sure saucectl version is newer than **v0.44.0**

### Set Your Sauce Labs Credentials

```shell
saucectl configure
```

## Running The Examples

Simply check out this repo, set your XCUITest test bundles and run the appropriate command below :rocket:

:bulb: We also provide [DemoApp](DemoApp/) to demonstrate the test workflow. Click [here](.github/workflows/test.yml) for more details on how to build your XCUITest test pipeline.

To download prebuilt demo apps, run "sh ./scripts/download-test-apps.sh" and the apps will download to a directory called "demo-apps/"

### Build `DemoApp` for Real Device

```shell
cd DemoApp

xcodebuild \
  CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO \
  clean build-for-testing \
  -project DemoApp.xcodeproj \
  -scheme "DemoApp" \
  -sdk iphoneos \
  -configuration Debug \
  -derivedDataPath build
```

### Run XCUITest on Sauce Cloud Real Device

```shell
APP=DemoApp/build/Build/Products/Debug-iphoneos/DemoApp.app \
TEST_APP=DemoApp/build/Build/Products/Debug-iphoneos/DemoAppUITests-Runner.app \
saucectl run
```
![sauce cloud example](assets/xcuitest.gif)

### Build `DemoApp` for Simulator

```shell
cd DemoApp

xcodebuild \
  CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO \
  clean build-for-testing \
  -project DemoApp.xcodeproj \
  -scheme "DemoApp" \
  -sdk iphonesimulator \
  -configuration Debug \
  -derivedDataPath build
```
### Run XCUITest on Sauce Cloud Simulator

```shell
APP=DemoApp/build/Build/Products/Debug-iphonesimulator/DemoApp.app \
TEST_APP=DemoApp/build/Build/Products/Debug-iphonesimulator/DemoAppUITests-Runner.app \
saucectl run -c .sauce/simulator-config.yml
```

### Run XCUITest in Parallel

`saucectl` supports running tests in parallel by setting `shard` and `testListFile` in sauce config. Click [here](.sauce/sharding-config.yml) to check the details.

During the build phase of the DemoApp project, a script is available to extract test classes. As a result, when you build DemoApp using the provided repository, it generates a `DemoApp/test_classes_and_tests.txt` file. This file can be used for sharding XCUITest based on concurrency. Furthermore, you have the flexibility to create your own `testListFile` as required.

```
APP=DemoApp/build/Build/Products/Debug-iphoneos/DemoApp.app \
TEST_APP=DemoApp/build/Build/Products/Debug-iphoneos/DemoAppUITests-Runner.app \
TEST_LIST_FILE=DemoApp/test_classes_and_tests.txt \
saucectl run -c .sauce/sharding-config.yml
```


## The Config

[Follow me](.sauce/config.yml) if you'd like to see how saucectl is configured for this repository.

[Sharding Config](.sauce/sharding-config.yml) if you'd like to see how saucectl is configured to run XCUITest in parallel.

[Simulator Config](.sauce/simulator-config.yml) if you'd like to see how saucectl is configured to run XCUITest with a simulator.

Our IDE Integrations (e.g. [Visual Studio Code](https://docs.saucelabs.com/dev/cli/saucectl/usage/ide/vscode/)) can help you out by validating the YAML files and provide handy suggestions, so make sure to check them out!
