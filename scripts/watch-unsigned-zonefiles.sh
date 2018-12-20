#!/bin/bash
unsigned_zonefiles_dir=/var/opendnssec/unsigned/
inotifywait --monitor --recursive --event modify $zonefiles_dir |
  while read path _ zone; do
    if nsd-checkzone $zone $zonefiles_dir$zone; then
      echo "Reloading zone $zone" > /dev/stdout
      nsd-control reload $zone
    else
      echo "Could not reload zone $zone, because the zonefile is invalid" > /dev/stderr
    fi
  done
