New Kickstart



The following Foreman parameters are used in this kickstart:

* luks
If set to 'true', the primary disk will be encrypted during the install.

* luks-passphrase   
Defines the password to use whilst encrypting the primary disk

* luks-tang-key1 / luks-tang-key2
If defined, Network Bound Disk Encryption will be configured. These parameters define the public
thumbprint of two 'Tang' NBDE servers.
(The servers themselves are currently hard-coded in snippet_ISM)


* localhomedirs
If set to 'true' a larger /home partition will be created, and oddjobd will be configured to create
homedirs on first login. If set to 'false' a small placeholder /home partition will be created, and
home directories will be automounted from a defined location.


* ptable
This is used to configure additional per host(group) partitioning by sourcing a 'ptable' snippet.
To source an additional partition definition that creates a Satellite Capsule partition layout for
example,  set the 'ptable' parameter to 'capsule'.  This will add the ptable_capsule snippet to the
generic partition table.

* time-zone
Overrides the default timezone for a host (default is 'Australia/Sydney'). Define the 'time-zone'
parameter value as the string of the desired timezone.

* ntp-server
Specific NTP server to sync time from during the kickstart. If not defined the defaults are used.

* ad
If this parameter is defined, the host will be enrolled in the Active Directory domain specified.
For example to join the domain EXAMPLE.COM, set 'ad' to 'EXAMPLE.COM'

* ad_join_user
AD user with permission to join hosts to the domain - used with 'ad' parameter.

* ad_join_passwd
Password for the user defined in 'ad_join_user'


* ldap



* idm_server
Specific IdM server to use for enrolment. This only needs to be defined if DNS lookup of the IdM
servers is not working from the subnet being built on.

* idm_domain
Only need to be defined if the domain differs from the IdM realm defined in Foreman.

* idm_opts
Additional parameters to pass to the 'ipa-client-install' utility during the enrolment process.

* idm_automount_location
If 'localhomedirs' is false, IdM automount will be configured using the location defined in this
parameter. If this parameter is not defined, the 'default' location will be used.





* auto_update
If set to 'true', yum-cron will be installed and configured to automatically apply updates.
Note that setting this to true does NOT result in auto-reboot of the host - you will still need
to check and reboot if required after errata is applied (use the 'needs-restarting -r' command)


* server_gui
If set to 'true', the X-Windows and GNOME environments will be installed and configured.

* headless
If set to 'true', the host will be configured with a text-based console even though the X-Windows
packages are installed.

* xrdp
If set to 'true', the XRDP package will be installed and configured, allowing Remote Desktop Protocol
connections to the graphical desktop.


* nessus_host
If this parameter exists, the host will be enrolled to the Nessus scanning server defined by the
value of this parameter.  To enrol to 'nessus.example.com', set  'nessus_host' to 'nessus.example.com'

* sophos
If this parameter is set to 'true', the Sophos Anti Virus agent will be installed and configured.

* syslog_server
The rsyslog process will be configured to forward logs to the server specified by this parameter.

* kt_activation_keys
Activation key to use when registering with Red Hat Satellite. This will normally be auto-populated
by Satellite itself via Host Group configuration, but may be overridden if required.
