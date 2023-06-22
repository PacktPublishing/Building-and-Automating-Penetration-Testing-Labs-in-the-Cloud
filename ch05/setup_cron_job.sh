#!/bin/bash
set -x

(crontab -l 2>/dev/null; echo "@reboot sleep 60 && /usr/bin/vncserver") | crontab -
(crontab -l 2>/dev/null; echo "@reboot sleep 60 && /usr/share/novnc/utils/novnc_proxy --listen 0.0.0.0:8081 --vnc localhost:5901 >/dev/null 2>&1 &") | crontab -
