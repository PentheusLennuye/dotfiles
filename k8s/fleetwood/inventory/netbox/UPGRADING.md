# Upgrading Netbox versions

To update Netbox to a new version, change the image tag in _local_values.yml_
and:

```sh
helm upgrade netbox -n cummings-online-local --devel -f local_values.yaml \
  oci://ghcr.io/netbox-community/netbox-chart/netbox
```

