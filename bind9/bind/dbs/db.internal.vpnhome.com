;$include "/etc/bind/db.vpnhome.com"
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     ns1.vpnhome.com. root.vpnhome.com. (
                            150         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@                       IN      NS              ns1.vpnhome.com.
@                       IN      NS              ns2.vpnhome.com.
;@                       IN      A               192.168.8.53
;www                     IN      A               192.168.8.53
@                       IN      A               10.10.10.1
www                     IN      A               10.10.10.1
ns1                     IN      A               10.10.10.1
ns2                     IN      A               10.10.10.1
;
; External sites
;
;
; Mail
;

;
; Server addresses
;
;
; Other computer paths
;
;
; Virtual machine paths
;
;
; Services' paths
;
;
; Internal sites
;
;
; External sites which need also to be can accessed internally
;
;
; temporary stuffs
;
;
; Mail
;
@				IN     MX	5	mail.internal
;
; Proxy stuffs
;

;
; Temporary fields to get certificate
;
