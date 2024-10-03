#!/bin/bash
echo y | sdkmanager "ndk;${PARAM_VER}"
android_ndk_home=""
  if [[ -d "${HOME}/android-sdk/ndk/${PARAM_VER}" ]]; then
    android_ndk_home="$HOME/android-sdk/ndk/${PARAM_VER}"
  elif [[ -d "/opt/android/sdk/ndk/${PARAM_VER}" ]]; then
    android_ndk_home="/opt/android/sdk/ndk/${PARAM_VER}"
  else
    echo "Android NDK did not install successfully"
    exit 1
  fi
echo "export ANDROID_NDK_HOME=$android_ndk_home" >> "$BASH_ENV"
echo "Android NDK was installed at \"$android_ndk_home\"."