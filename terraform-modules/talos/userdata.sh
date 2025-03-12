#!/bin/bash

KERNEL_URL="https://pxe.factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/v1.8.3/kernel-amd64"
INITRD_URL="https://pxe.factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/v1.8.3/initramfs-amd64.xz"
CMDLINE="talos.platform=metal talos.exp.wipe=system console=tty0 init_on_alloc=1 slab_nomerge pti=on consoleblank=0 nvme_core.io_timeout=4294967295 printk.devkmsg=on ima_template=ima-ng ima_appraise=fix ima_hash=sha512"

wget -O /boot/talos-vmlinuz $KERNEL_URL
wget -O /boot/talos-initrd.xz $INITRD_URL

apt install kexec-tools -y

kexec -l /boot/talos-vmlinuz --initrd=/boot/talos-initrd.xz --append="$CMDLINE"
kexec -e
