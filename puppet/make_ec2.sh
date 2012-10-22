#!/bin/sh -ex
# Build an EC2 bundle and upload/register it to Amazon

IMG=mirage.img
NAME=mirage-os
BUCKET=mirage-os-apps
MNT=/mnt/mirage
SUDO=sudo

if [ ! -e "$1" ]; then
  echo Usage: $0 kernel.xen
  exit 1
fi

${SUDO} mkdir -p /mnt/mirage
rm -f ${IMG}
dd if=/dev/zero of=${IMG} bs=1M count=5
${SUDO} mke2fs -F -j ${IMG}
${SUDO} mount -o loop ${IMG} ${MNT}

${SUDO} mkdir -p ${MNT}/boot/grub
echo default 0 > menu.lst
echo timeout 1 >> menu.lst
echo title Mirage >> menu.lst
echo " root (hd0)" >> menu.lst
echo " kernel /boot/mirage-os.gz" >> menu.lst
${SUDO} mv menu.lst ${MNT}/boot/grub/menu.lst

${SUDO} sh -c "gzip -c $1 > ${MNT}/boot/mirage-os.gz"
${SUDO} umount -d ${MNT}

rm -rf ec2_tmp
mkdir ec2_tmp
ec2-bundle-image -i ${IMG} -k ${EC2_PRIVATE_KEY} -c ${EC2_CERT} -u ${EC2_USER} -d ec2_tmp -r x86_64 --kernel aki-427d952b
http_proxy="" ec2-upload-bundle -b ${BUCKET} -m ec2_tmp/${IMG}.manifest.xml -a ${EC2_ACCESS} -s ${EC2_ACCESS_SECRET}
rm -rf ec2_tmp
ec2-register ${BUCKET}/${IMG}.manifest.xml
