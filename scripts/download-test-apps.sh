#!/bin/bash
# INSTALL SAUCECTL
curl -L https://saucelabs.github.io/saucectl/install | bash

# GET URL'S FOR SAMPLE REAL DEVICE APP AND XCTEST APP FROM GITHUB
app_repo=saucelabs/my-demo-app-ios
echo "Using sample apps from https://github.com/saucelabs/my-demo-app-ios/releases" 
latest_tag=$(curl -s "https://api.github.com/repos/$app_repo/releases/latest" | grep -o '"tag_name": ".*"' | sed 's/"tag_name": "//' | sed 's/"$//')

# APP AND TEST_APP. TO USE YOUR OWN, REPLACE THESE WITH A URL OR PATH TO YOUR OWN IPA AND TEST IPA
export APP=https://github.com/$app_repo/releases/download/$latest_tag/SauceLabs-Demo-App.ipa
export TEST_APP=https://github.com/$app_repo/releases/download/$latest_tag/SauceLabs-Demo-App-Runner.XCUITest.ipa

# Create folder if it doesn't exist
mkdir -p demo-apps

# Download and save the apps
curl -L $APP -o demo-apps/SauceLabs-Demo-App.ipa
curl -L $TEST_APP -o demo-apps/SauceLabs-Demo-App-Runner.XCUITest.ipa
