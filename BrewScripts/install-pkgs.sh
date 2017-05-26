#!/usr/bin/env bash

source ../env-setup.sh

BREW_CASK_PKGS=`cat brew-cask-pkgs-all.txt brew-cask-pkgs-${SYSTEM_PROFILE}.txt | sort | uniq | xargs echo`
BREW_PKGS=`cat brew-pkgs-all.txt brew-pkgs-${SYSTEM_PROFILE}.txt | sort | uniq | xargs echo`
BREW_TAPS=`cat brew-taps-all.txt brew-taps-${SYSTEM_PROFILE}.txt | sort | uniq | xargs echo`

brew update
brew upgrade

echo "Enabling taps ..."
for TAP in $BREW_TAPS; do
	brew tap ${TAP}
done

# Install missing Homebrew packages
echo "Install missing packages ..."
for PACKAGE in $BREW_PKGS; do
	brew list ${PACKAGE} >/dev/null
	[ "$?" != "0" ] && brew install ${PACKAGE}
done

echo "Install missing casks ..."
for CASK in $BREW_CASK_PKGS; do
	brew cask list -1 ${CASK} >/dev/null
	[ "$?" != "0" ] && brew cask install ${CASK}
done
