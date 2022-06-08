#!/bin/bash
set -euo pipefail

while true; do
    telnet localhost 19021 | tee -i /tmp/telnet.cap || sleep 1
done
