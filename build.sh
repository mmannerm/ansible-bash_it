#!/bin/bash
set -e

build_dir="/tmp/osx-build"
source_dir="/Applications"
vm_template_repo="https://github.com/timsutton/osx-vm-templates.git"
prepare_flags="-D DISABLE_REMOTE_MANAGEMENT"
packer_flags=""

# Clone osx-vm-templates if not already existing
if [ ! -d "${build_dir}/osx-vm-templates" ]; then
    mkdir -p ${build_dir}
    cd ${build_dir}; git clone ${vm_template_repo} osx-vm-templates
fi

# Prepare ISOs for all OS X install images, if any image does not exist yet
if [ "$(ls -A ${build_dir}/images)" ]; then
    echo "There are existing prepared vm-images, skipping prepare-iso phase."
else
    for f in ${source_dir}/Install\ OS\ X*.app
    do
        [ -e "$f" ] || break
        echo "Preparing $f"
        sudo ${build_dir}/osx-vm-templates/prepare_iso/prepare_iso.sh ${prepare_flags} "${f}" "${build_dir}/images"
    done
    for f in ${source_dir}/Install\ macOS*.app
    do
        [ -e "$f" ] || break
        echo "Preparing $f"
        sudo ${build_dir}/osx-vm-templates/prepare_iso/prepare_iso.sh ${prepare_flags} "${f}" "${build_dir}/images"
    done
fi

for f in ${build_dir}/images/*.dmg
do
    cd ${build_dir}/osx-vm-templates/packer; packer build -var iso_url=${f} ${packer_flags} template.json || true
    mv ${build_dir}/osx-vm-templates/packer/packer_virtualbox-iso_virtualbox.box ${build_dir}/$(basename $f .dmg | awk -F_ '{ print $3 }' | awk -F. '{ print "macosx-" $1 "." $2 }').box
done

