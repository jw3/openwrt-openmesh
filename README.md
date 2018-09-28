OpenWRT on Open-Mesh
=====

Docker based firmware build and flasher for the OpenWRT firmware and Open-Mesh hardware.

### building

After the build completes the firmware will be in `/tmp`:

```
ls /tmp | grep openwrt
openwrt-ar71xx-generic-om2p-squashfs-factory.bin
openwrt-ar71xx-generic-om2p-squashfs-sysupgrade.bin
openwrt-ar71xx-generic-uImage-lzma.bin
openwrt-ar71xx-generic-vmlinux.bin
```

The `ap51-flash` tool will be in `/usr/local/bin`

### flashing

Using docker image

```
docker run --rm --privileged openwrt-openmesh ap51-flash eth /tmp/openwrt-ar71xx-generic-om2p-squashfs-factory.bin
```

Then plugin the OM2P in eth0 and power it up.

The output of the flash tool should look like this:

```
  [MA:C-:AD:DR:ES:S ]: type 'OM2P router' detected
  [MA:C-:AD:DR:ES:S ]: OM2P router: tftp client asks for 'fwupgrade.cfg', serving fwupgrade.cfg portion of: openwrt-ar71xx-generic-om2p-squashfs-factory.bin (1 blocks) ...
  [MA:C-:AD:DR:ES:S ]: OM2P router: tftp client asks for 'kernel', serving kernel portion of: openwrt-ar71xx-generic-om2p-squashfs-factory.bin (1993 blocks) ...
  [MA:C-:AD:DR:ES:S ]: OM2P router: tftp client asks for 'rootfs', serving rootfs portion of: openwrt-ar71xx-generic-om2p-squashfs-factory.bin (4609 blocks) ...
  [MA:C-:AD:DR:ES:S ]: OM2P router: image successfully transmitted - writing image to flash ...
  [MA:C-:AD:DR:ES:S ]: OM2P router: flash complete. Device ready to unplug.
```

### post-flash configuration

- Connect via ssh `ssh root@192.168.1.1`
- Set the root password `passwd`
- Enable wifi `uci set wireless.@wifi-device[0].disabled=0; uci commit wireless; wifi`
- Install the configuration webapp

```
opkg update
opkg install luci
```

or for ssl use `luci-ssl`

- Start webapp `/etc/init.d/uhttpd start`
- Start webapp on boot `/etc/init.d/uhttpd enable`
- Access GUI at https://192.168.1.1

### upgrades

The recommended way to upgrade is via the "sysupgrade" script. Just copy the factory image (openwrt-ar71xx-generic-om2p-squashfs-factory.bin) to the /tmp folder and run:

`sysupgrade /tmp/openwrt-ar71xx-generic-om2p-squashfs-factory.bin`

### source

https://wiki.openwrt.org/toh/openmesh/om2p

### errors

- `odhcpd-ipv6only`
  - check_data_file_clashes: Package odhcpd-ipv6only wants to install file /openwrt/build_dir/target-mips_24kc_musl/root-ar71xx/etc/init.d/odhcpd But that file is already provided by package  * odhcpd
  - https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=c7b052db739e50f8a40f95ac17a21363b1593e33
  - https://lists.openwrt.org/pipermail/openwrt-devel/2017-December/010191.html

### references
- https://wiki.openwrt.org/toh/openmesh/om2p
- https://help.cloudtrax.com/hc/en-us/articles/202487954-Open-Mesh-and-OpenWRT
- https://help.cloudtrax.com/hc/en-us/articles/202382890-Open-Mesh-development-information
- https://openwrt.org/docs/guide-user/luci/luci.essentials-tomerge

### history

[Issue #42](https://github.com/jw3/mvf/issues/42) in the mvf project tracked some original progress on this.

Initial development of this took place over in that repository.
