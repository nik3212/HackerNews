#!/bin/sh

which -s xcodegen
if [[ $? != 0 ]] ; then
    # Install xcodegen
	echo "Installing xcodegen."
    brew install xcodegen
fi

which -s swiftgen
if [[ $? != 0 ]] ; then
    # Install swiftgen
	echo "Installing swiftgen."
    brew install swiftgen
fi