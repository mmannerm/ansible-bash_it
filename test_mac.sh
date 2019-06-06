#!/bin/bash
set -ex

source_dir="/Applications"

function add_to_file() {
    line=${1}

    grep -qxF "${line}" $2 || echo "${line}" >> $2
}

if ! [ -x "$(command -v rbenv)" ]; then
    brew install rbenv
    add_to_file 'eval "$(rbenv init -)"' ~/.bash_profile
    rbenv install 2.6.3
    gem install bundler
    bundler install
fi

for f in ${source_dir}/Install\ macOS*.app; do
    version=$(/usr/libexec/PlistBuddy -c 'Print :System\ Image\ Info:version' "${f}/Contents/SharedSupport/InstallInfo.plist")
    if [ -d "${HOME}/.vagrant.d/boxes/macos/${version}" ]; then
        echo "Skipping macos-${version} as it already exists."
    else
        sudo bundler exec macinbox --name macos --installer "${f}" --box-format virtualbox --no-gui --no-fullscreen
    fi
done

bundle exec kitchen test
