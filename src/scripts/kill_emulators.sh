#!/bin/bash
# shellcheck disable=SC2154
adb devices | grep emulator | cut -f1 | while read -r line; do adb -s $line emu kill; done