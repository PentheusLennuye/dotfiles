# Some Nice Virsh Commands

## Create a static address allocation to DHCP

```sh
virsh net-update local add ip-dhcp-host \
  "<host mac='52:54:00:57:cc:8b' ip='192.168.173.215' name='ubuntuprime'/>" \
  --config --live
```

where 'local' is the name of the network, --config means to update the
persistent configuration, and --live means to make it instantly ready.

## Dump the network configuration

```sh
virsh net-dumpxml local > myconfig.xml
```

where 'local' is the name of the network.


## Blow Up the Network

```sh
virsh net-destroy local
```

where 'local' is the name of the network.


## Redefine the Network from Config

```sh
virsh net-define myconfig.xml
```

## Start the Network and (Optionally) Make it Autostart

```sh
virsh net-start local
virsh net-autostart local
```

