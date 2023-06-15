# INSTALL SAUCECTL
curl -L https://saucelabs.github.io/saucectl/install | bash

# GET URL'S FOR SAMPLE SIMULATOR APP AND XCTEST APP FROM GITHUB
app_repo=saucelabs/my-demo-app-ios
echo "Using sample apps from https://github.com/saucelabs/my-demo-app-ios/releases" 
latest_tag=$(curl -s "https://api.github.com/repos/$app_repo/releases/latest" | grep -o '"tag_name": ".*"' | sed 's/"tag_name": "//' | sed 's/"$//')

# APP AND TEST_APP. TO USE YOUR OWN, REPLACE THESE WITH A URL OR PATH TO YOUR OWN IPA AND TEST IPA
export APP=https://github.com/$app_repo/releases/download/$latest_tag/SauceLabs-Demo-App.ipa
export TEST_APP=https://github.com/$app_repo/releases/download/$latest_tag/SauceLabs-Demo-App-Runner.XCUITest.ipa

# SET BUILD NAME
DATE_TIME=$(date +"%Y-%m-%d %H:%M:%S")
export DEFAULT_BUILD_NAME="Gitpod Build $DATE_TIME"
: "${BUILD:=$DEFAULT_BUILD_NAME}"

# SET REGION
DEFAULT_REGION="us-west-1"
export REGION=${REGION:=$DEFAULT_REGION}

echo ""
echo "======================================================"
echo "Running Apple XCUITest tests on APP=$APP and TEST_APP=$TEST_APP in Sauce Labs cloud!"
echo ""
echo "To vew your test results in real time visit https://app.$REGION.saucelabs.com/dashboard/builds/rdc and open the build with name 'Gitpod Build $DATE_TIME'"
echo "======================================================"
echo ""
sleep 8

./bin/saucectl run --region $REGION --build "$BUILD"
