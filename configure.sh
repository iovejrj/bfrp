#!/bin/sh
# Download and install frps
curl -L -H "Cache-Control: no-cache" -o frp.tar.gz https://github.com/fatedier/frp/releases/download/v0.34.3/frp_0.34.3_linux_amd64.tar.gz
tar -zxvf frp.tar.gz
mv frp_0.34.3_linux_arm64 frp
cd frp
cat <<-EOF > frp_server.ini
[common]
bind_addr = 0.0.0.0
bind_port = 7000

# udp port to help make udp hole to penetrate nat
bind_udp_port = 7001
kcp_bind_port = 7000
vhost_http_port = 80
vhost_https_port = 443

log_file = ./frps.log

# trace, debug, info, warn, error
log_level = info
log_max_days = 3
detailed_errors_to_client = true

authentication_method = token
authenticate_heartbeats = false
authenticate_new_work_conns = false
token = 1234567890

max_pool_count = 5
max_ports_per_client = 0
tls_only = false

# if tcp stream multiplexing is used, default is true
tcp_mux = true

# custom 404 page for HTTP requests
# custom_404_page = /path/to/404.html

udp_packet_size = 1500

EOF
cp systemd/frps.service  /usr/lib/systemd/system
sudo systemctl enable frps
sudo systemctl start frps
#/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
