#!/bin/sh
set -ex

INSTALL_PATH=$WORKSPACE/artifacts
[ -z $WORKSPACE ] && INSTALL_PATH=$PWD/artifacts

rm -rf $INSTALL_PATH
mkdir -p $INSTALL_PATH

TARGET=MAConfirmButton 
PROJ=MAConfirmButton.xcodeproj 

xcodebuild -project $PROJ -sdk iphoneos INSTALL_ROOT=$INSTALL_PATH/device install
xcodebuild -project $PROJ -sdk iphonesimulator INSTALL_ROOT=$INSTALL_PATH/simulator install

lipo -create -output $INSTALL_PATH/lib$TARGET.a $INSTALL_PATH/device/lib$TARGET.a $INSTALL_PATH/simulator/lib$TARGET.a
mv $INSTALL_PATH/device/Headers $INSTALL_PATH
rm -rf $INSTALL_PATH/device $INSTALL_PATH/simulator
(cd $INSTALL_PATH; zip -r ../$TARGET.zip lib$TARGET.a Headers)
