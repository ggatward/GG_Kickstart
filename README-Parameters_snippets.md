# SNIPPET KS PARAMETERS

The following Foreman parameters are used in the snippet extension component of this kickstart:

### Active Directory parameters
```
- ad_realm = <string>                           AD realm to join [Default: ""]
- ad_join_user = <user>                         User with permission to join AD domain
- ad_join_passwd = <password>                   Password for AD join user
- ad_join_ou = <string>                         OU string if machine needs to be enrolled into a specific OU
```

### POSIX LDAP parameters
```
- ldap_server = <uri>                           LDAP server to use (prefix with ldaps://) [Default: ""]
- ldap_basedn = <string>                        LDAP Base DN
```

### Misc parameters
```
- disable_thp = [true|false]                    Disable Transparent Huge Pages [Default: false]
- add_ansible_user = [true|false]               Create pre-canned Ansible user (not standard Satellite one) [Default: false]
- auto_update = [true|false]                    Enable automated patching [Default: false]
- auto_update_security = [true|false]           Only apply security updates [Default: false]
- nessus_host = <fqdn>                          Nessus Scanner host to use. Nessus not installed if undef. [Default: ""]
- splunk_host = <fqdn>                          Splunk Deployment server to register with. Splunkforwarder not installed if undef. [Default: ""]
- sophos = [true|false]                         Install sophos AV agent [Default: false]
```

### Graphical Desktop parameters
```
- server_gui = [true|false]                     Install the GUI packages and configure as a workstation [Default: false]
- gui_desktop_background = <url>                URL of background wallpaper to use [Default: ""]
- gui_desktop_logo = <url>                      URL of logo to use [Default: ""]
- headless = [true|false]                       Boot in text mode even though GUI is installed [Default: false]
- nvidia = [true|false]                         Install NVIDIA graphics driver [Default: false]
- xrdp = [true|false]                           Install and configure XRDP [Default: false]
```

### Hardening parameters
```- ignore_umask_hardening = [true|false]         Don't apply umask hardening parameters [Default: false]
- syslog_server = <fqdn>                        Syslog server to send events to [Default: ""]
- disable_ipv6 = [true|false]                   Disable IPv6 support [Default: true]
- stroom_audit = [true|false]                   Use Stroom audit agent [Default: false]
```
