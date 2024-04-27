# stm32mp1 note
how to build a image with scipy support

https://www.cocoacrumbs.com/blog/2021-10-15-building-a-linux-distro-for-the-stm32mp157f-dk2/

https://www.cocoacrumbs.com/blog/2021-10-16-building-the-st-linux-distro-for-the-stm32mp157f-dk2/

https://github.com/darkquesh/stm32mp1

https://github.com/cvetaevvitaliy/stm32mp1-ubuntu

https://bootlin.com/blog/building-a-linux-system-for-the-stm32mp1-basic-system/

https://forum.digikey.com/t/debian-getting-started-with-the-stm32mp157/12459


https://community.st.com/t5/stm32-mpus-products/scipy-and-librosa-libraries-on-st-mp1-linux/td-p/58926

https://github.com/tuxable-ltd/meta-scipy/tree/master

https://github.com/meta-qt5/meta-qt5


https://wiki.st.com/stm32mpu/wiki/STM32MP1_Distribution_Package


    repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-6.1-yocto-mickledore-mp1-v23.06.21
    repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-6.1-yocto-mickledore-mp1-v24.03.13

repo sync
## edit

code openembedded-core/bitbake/lib/bb/utils.py

        def disable_network(uid=None, gid=None):
            """
            Disable networking in the current process if the kernel supports it, else
            just return after logging to debug. To do this we need to create a new user
            namespace, then map back to the original uid/gid.
            """
            return

git clone -b mickledore https://github.com/zboszor/meta-python-ai meta-python-ai

bitbake-layers add-layer /work/layers/meta-python-ai
  
bitbake-layers show-layers


DISTRO=openstlinux-weston MACHINE=stm32mp15-disco source layers/meta-st/scripts/envsetup.sh

https://www.wolfssl.com/docs/yocto-openembedded-recipe-guide/


/conf/local.conf

      FORTRAN:forcevariable = ",fortran"
      RUNTIMETARGET:append:pn-gcc-runtime = " libquadmath"

      BB_NUMBER_THREADS = "20"
      PARALLEL_MAKE = "-j 20"
      IMAGE:INSTALL:append = " packagegroup-core-buildessential"
      IMAGE:INSTALL:append = "python3-scipy"
      IMAGE:INSTALL:append = "python3-pip"
      IMAGE:INSTALL:append = "python3-matplotlib"
      IMAGE:INSTALL:append = "python3-pandas"
      IMAGE:INSTALL:append = "networkmanager"

add in st-image-weston.bb

# Define ROOTFS_MAXSIZE to 32GB
IMAGE_ROOTFS_MAXSIZE = "33554432"

CORE_IMAGE_EXTRA_INSTALL +=

        packagegroup-core-buildessential \
        packagegroup-framework-sample-qtwayland \
        python3-scipy \
        python3-pip \
        python3-matplotlib \
        python3-pandas \
        networkmanager \

bitbake st-image-weston


cd tmp-glibc/deploy/images/stm32mp15-disco/scripts/

./create_sdcard_from_flashlayout.sh ../flashlayout_st-image-weston/extensible/FlashLayout_sdcard_stm32mp157f-dk2-extensible.tsv 


        sudo umount `lsblk --list | grep sdb | grep part | gawk '{ print $7 }' | tr '\n' ' '`

sudo dd if=../flashlayout_st-image-weston/extensible/../../FlashLayout_sdcard_stm32mp157f-dk2-extensible.raw of=/dev/sdb bs=8M conv=fdatasync status=progress oflag=direct




https://wiki.st.com/stm32mpu/wiki/How_to_setup_a_WLAN_connection

https://github.com/tuxable-ltd/meta-scipy

https://layers.openembedded.org/layerindex/recipe/404069/

apt-get install qtwayland python3-pyqt5

QT_QPA_PLATFORM=wayland-egl python3 /home/weston/filename.py

apt install networkmanager-nmtui

pip3 install pyqtgraph


