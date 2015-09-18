#!/bin/bash

cd mozilla-release

export MOZ_VERSION=$(head -n1 browser/config/version.txt)

cd obj-firefox

export DMG_FILE_NAME=CLIQZ-$MOZ_VERSION.$LANG.mac64.dmg

echo "***** MAC SIGNING *****"
echo "DMG FILE NAME: $DMG_FILE_NAME"

mkdir pkg
hdiutil attach dist/$DMG_FILE_NAME
cp -r /Volumes/CLIQZ/CLIQZ.app pkg
codesign -s "CLIQZ Gmbh" --deep ./pkg/CLIQZ.app
codesign -s "CLIQZ Gmbh" ./dist/*.mar
hdiutil detach /Volumes/CLIQZ
rm dist/$DMG_FILE_NAME
appdmg ../../CLIQZ-dmg.json dist/$DMG_FILE_NAME