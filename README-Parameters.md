BASELINE PARAMETERS

The following Foreman parameters are used in the baseline component of this kickstart:

##################################################################################
#
# Generic build parameters
- lang = <string>                               System Language [Default: en_US.UTF-8]
- keyboard = <string>                           System Keyboard [Default: us]
- selinux-mode = <string>                       SELinux mode to configure [Default: enforcing]
- disable-firewall = [true|false]               Disable system firewall during build [Default: false]
- bootloader-append = <string>                  Options to append to bootloader [Default: nofb quiet splash=quiet]
- disable-uek = [true|false]                    If installing OEL, disable UE Kernel [Default: false]
- kickstart_liveimg =
- blacklist_kernel_modules = <string>           Space seperated list of kernel modules to blacklist [Default: ""]
- use-ntp = [true|false]                        Use ntpd instead of chrony [Default depends on OS release]
- ntp-server = <fqdn>                           NTP server to sync with during kickstart [Default: 0.fedora.pool.ntp.org]
- time-zone = <string>                          Timezone to configure [Default: UTC]
- http-proxy = <fqdn>                           HTTP Proxy for Internet Access [Default: ""]
- http-proxy-port = <port>                      HTTP Proxy TCP port [Default: ""]
- http-proxy-user = <user>                      Proxy user to be used for registration
- http-proxy-password = <password>              Proxy password to be used for registration
- package_upgrade = [true|false]                Perform full package update during build [Default: true]

##################################################################################
#
# Disk encryption parameters
- luks = [true|false]                           Encrypt boot device with LUKS and NBDE [Default: false]
- luks-passphrase = <password>                  Passphrase for local disk unlock
- luks-tang-server1 = <fqdn>                    FQDN of Tang server #1
- luks-tang-key1 = <string>                     Shared key for tang server #1
- luks-tang-server2 = <fqdn>                    FQDN of Tang server #2
- luks-tang-key2 = <string>                     Shared key for tang server #2


##################################################################################
#
# Snippet-based provisioning
- extra_snippet_entry = <string>      Name of the snippet used as the entrypoint to remaining snippets

##################################################################################
#
# EPEL repository handling - don't use these parameters if EPEL provided by Satellite
- enable-epel = [true|false]                    Enable internet EPEL repository [Default: false]
- epel-repo-base = <url>                        Base URL of EPEL repo  [Default: dl.fedoraproject.org/epel]

##################################################################################
#
# FreeIPA parameters
- freeipa_server = <fqdn>                       Use specific IPA server instead of discovery
- freeipa_sudo = [true|false]                   Enable sudoers  [Default: true]
- freeipa_ssh = [true|false]                    Enable ssh integration  [Default: true]
- freeipa_automount = [true|false]              Enable automounter  [Default: false]
- freeipa_automount_location                    Location for automounts
- freeipa_mkhomedir = [true|false]              Enable automatically making home directories  [Default: true]
- freeipa_opts = <string>                       Additional options to pass directly to installer
- freeipa_automount_server = <fqdn>             Override automount server different to freeipa_server
- freeipa_domain = <domain>                     Use specific IPA domain instead of using realm discovery

# Devilhorn Parameters
- freeipa_svcprincipal = <username>             IPA service account with permission to add hosts to host groups
- freeipa_svcprincipal_pass = <password>        Password for IPA service account
- freeipa_host_groups = <string>                Space seperated list of host_groups to add host to on enrolment

##################################################################################
#
# Red Hat subscription registration parameters
- redhat_install_agent = [true|false]           Install OSAD for spacewalk, katello-agent for Satellite 6
- redhat_install_host_tools = [true|false]      Install the katello-host-tools yum/dnf plugins.
- redhat_install_host_tracer_tools = [true|false]  Install the katello-host-tools Tracer yum/dnf plugin.
- activation_key = <key>                        Activation key string, not needed if using subscription-manager with username/password
- atomic = [true|false]                         Whether or not this system is Atomic

# Parameters for use with subscription-manager (Red Hat CDN, Satellite, or Katello)
- subscription_manager = [true|false]           You're going to use subscription-manager
- subscription_manager_username = <username>    Username for subscription-manager
- subscription_manager_password = <password>    Password for subscription-manager
- subscription_manager_certpkg_url = <url>      Custom certificate package URL
- subscription_manager_atomic_url = <url>       Script used for configuring Atomic servers for subscription-manager
- subscription_manager_org = <org name>         Organization name, if required
- subscription_manager_repos = <repos>          Additional repositories to enable after registration (e.g. sat-tools, epel)
- subscription_manager_pool = <pool>            Specific subscription pool to use (Not used with AK)
- subscription_manager_autoattach = [true|false] Run auto attach after registration
- syspurpose_role                               Sets the system purpose role
- syspurpose_usage                              Sets the system purpose usage
- syspurpose_sla                                Sets the system purpose SLA
- syspurpose_addons                             Sets the system purpose add-ons. Separate multiple values with commas.

# Set these parameters if you're using rhnreg_ks:
- spacewalk_host = <hostname>                   Hostname of Spacewalk server

##################################################################################
#
# Remote Execution & Ansible role integration parameters
- remote_execution_create_user = [true|false]   Create user if it doesnt exist [Default: false]
- remote_execution_ssh_user = <username>        Username for SSH (Ansible) user
- remote_execution_effective_user_method = <string>  Method for privilege escalation (e.g. sudo) [Default: ""]

# Parameters for use with Ansible Tower provisioning callback
- ansible_tower_provisioning = [true|false]     Perform provisioning callback to Tower [Default: false]
- ansible_host_config_key = <string>            Ansible Tower Job template config key
- ansible_tower_fqdn = <fqdn>                   FQDN of the Ansible Tower node
- ansible_job_template_id = <integer>           Template ID of the job to run

##################################################################################
#
# Puppet parameters (parameters not required if using puppet from Satellite repositories)
- force-puppet = [true|false]                   Force installation of puppet agent [Default: false]
- enable-puppetlabs-repo = [true|false]         Enable internet puppetlabs repo [Default: false]
- enable-puppetlabs-pc1-repo = [true|false]     Enable internet puppetlabs-pc1 repo [Default: false]
- enable-puppetlabs-puppet5-repo = [true|false] Enable internet puppetlabs-puppet5 repo [Default: false]

##################################################################################
#
# Salt configuration. Salt minion is not installed unless this parameter is defined
- salt_master = <fqdn>                          Address of salt master to register with [Default: ""]
