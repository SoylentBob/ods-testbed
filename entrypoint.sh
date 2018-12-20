#!/bin/bash

ods-enforcer-db-setup -f

softhsm2-util --init-token --slot 0 --label OpenDNSSEC --pin $HSM_PIN --so-pin $HSM_PIN

ods-control start
ods-enforcer update all

tail -f /dev/stdout
