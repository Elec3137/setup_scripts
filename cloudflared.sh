#!/bin/sh
sudo pacman -S --needed --noconfirm cloudflared

# creates a cloudflared service file and enables it (for dns over https)
sudo echo '[Unit]
Description=cloudflared DNS over HTTPS proxy
After=syslog.target network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/cloudflared proxy-dns --port 53 --upstream https://cloudflare-dns.com/dns-query
Restart=on-failure
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/cloudflared.service
systemctl enable cloudflared
# then, setting a network to redirect traffic to 127.0.0.1 should make use of this service
