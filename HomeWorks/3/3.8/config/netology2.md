```bash
    vagrant@netology2:~$ sudo -s
    root@netology2:/home/vagrant# apt -y install ipvsadm keepalived
    root@netology2:/home/vagrant# ipvsadm -A -t 172.28.128.120:80 -s rr
    root@netology2:/home/vagrant# ipvsadm -a -t 172.28.128.120:80 -r 172.28.128.80:80 -g -w 1
    root@netology2:/home/vagrant# ipvsadm -a -t 172.28.128.120:80 -r 172.28.128.100:80 -g -w 1

    root@netology2:/home/vagrant# nano /etc/keepalived/keepalived.conf
```
```bash
vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    track_interface {
        eth1
    }
    virtual_router_id 33
    priority 50
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass super_secret
    }
    virtual_ipaddress {
        172.28.128.120/24 dev eth0
    }
}

virtual_server 172.28.128.120 80 {
    delay_loop 10
    lvs_sched rr
    lvs_method DR
    persistence_timeout 5
    protocol TCP
    
    real_server 172.28.128.80 80 {
        weight 50
        TCP_CHECK {
            connect_timeout 3
        }
    }
    
    real_server 172.28.128.100 80 {
        weight 50
        TCP_CHECK {
            connect_timeout 3
        }
    }
  }
```

```bash
    root@netology2:/home/vagrant# systemctl start ipvsadm
    root@netology2:/home/vagrant# systemctl enable ipvsadm
    ipvsadm.service is not a native service, redirecting to systemd-sysv-install.
    Executing: /lib/systemd/systemd-sysv-install enable ipvsadm
    root@netology2:/home/vagrant# systemctl start keepalived
    root@netology2:/home/vagrant# systemctl enable keepalived
    Synchronizing state of keepalived.service with SysV service script with /lib/systemd/systemd-sysv-install.
    Executing: /lib/systemd/systemd-sysv-install enable keepalived
    root@netology2:/home/vagrant# reboot

```