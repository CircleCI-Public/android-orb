#!/bin/bash
echo 'export ANDROID_SDK_ROOT=$HOME/android-sdk'  >> $BASH_ENV

if [ -d $ANDROID_SDK_ROOT ]
then
    echo "Directory $ANDROID_SDK_ROOT already exists, so we're skipping the install."
    exit 0
fi

mkdir -p $ANDROID_SDK_ROOT/cmdline-tools
cd $ANDROID_SDK_ROOT/cmdline-tools

curl https://dl.google.com/android/repository/commandlinetools-mac-${PARAM_VER}_latest.zip -o sdk-tools.zip
unzip sdk-tools.zip
rm sdk-tools.zip
mv cmdline-tools latest

SDKMANAGER=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager

$SDKMANAGER "platform-tools"
$SDKMANAGER "platforms;android-32"
$SDKMANAGER "build-tools;32.0.0"

echo 'export PATH=$ANDROID_SDK_ROOT/tools/bin:$PATH'  >> $BASH_ENV
echo 'export PATH=$ANDROID_SDK_ROOT/tools:$PATH'  >> $BASH_ENV
echo 'export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH'  >> $BASH_ENV
echo 'export PATH=$ANDROID_SDK_ROOT/emulator:$PATH'  >> $BASH_ENV

echo "Android SDK was installed at \"$ANDROID_SDK_ROOT\"."