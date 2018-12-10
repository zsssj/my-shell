#!/bin/bash
NET=192.168.100
for n in $(seq 1 254); do
    ADDR=${NET}.${n}
    echo -e "${ADDR}\t$(dig -x ${ADDR} +short)"
done
