#!/bin/bash
# https://help.ubuntu.com/community/MacBookAir6-2/Trusty
# https://github.com/patjak/bcwc_pcie/wiki/Get-Started

ENABLER='/tmp/bcwc_pcie'


download_bcwc_pcie() {
    git clone https://github.com/patjak/bcwc_pcie.git $ENABLER
}

extract_firmware() {
    cd $ENABLER/firmware
    make
    sudo make install
    cd -
}

build_and_install_dkms() {
    cd $ENABLER
    make
    sudo checkinstall
    sudo depmod
    cd -
}

load_kernel_module() {
    echo -n "Remove bdc_pci module..."
    sudo rmmod bdc_pci
    echo "done."
    
    echo -n "Insert facetimehd module..."
    sudo modprobe facetimehd
    echo "done."
}

test_camera() {
    echo "Camera test.  A window streaming camera content should be popped up."
    mplayer tv://
}


download_bcwc_pcie
extract_firmware
build_and_install_dkms
load_kernel_module
test_camera
