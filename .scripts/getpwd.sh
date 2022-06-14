#!/bin/bash
cat ~/.mailpass |awk '/machine '$1' login '$2'/ {print $NF}'
