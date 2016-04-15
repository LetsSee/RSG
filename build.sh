#!/bin/sh
xcodebuild -workspace RSG.xcworkspace -scheme RSG clean
xcodebuild -workspace RSG.xcworkspace -scheme RSG archive
 
open ~/Builds/RSG

