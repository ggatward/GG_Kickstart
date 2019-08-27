This kickstart tree has been created for RHEL/CentOS 6/7/8 and Fedora 29+ hosts provisioned by Foreman 1.15/Satellite 6.3 onwards. Several Foreman parameters changed syntax at this release level, so this tree will NOT work
with earlier Foreman/Satellite versions.

The file structure used in this Kickstart tree allows for importing into Foreman/Satellite using the
TemplateSync plugin (Foreman 1.15 / Satellite 6.3).  The plugin can append a prefix to the name of all
erb files, however for this kickstart I am NOT making use of this. The artifacts in the repository have unique names for my installation and use 'GG' as their prefix - if changing this string you will need to find/replace all instances within all of the erb files within this project.

The base kickstart is a common bootstrap that will kickstart any host to a consistant baseline, from which puppet or Ansible can be used to complete the build. To handle environments that still require 'legacy' kickstart snippets, an entrypoint snippet can be defined from which the legacy provisioning snippets can be defined - this keeps the common baseline, well, common.

The following 'hammer' commands can be used to configure the TemplateSync plugin:
'''
hammer settings set --name template_sync_repo --value 'https://github.com/ggatward/GG_Kickstart.git'
hammer settings set --name template_sync_branch --value 'development'
hammer settings set --name template_sync_dirname --value '/'
hammer settings set --name template_sync_associate --value 'always'
hammer settings set --name template_sync_lock --value 'false'
hammer settings set --name template_sync_metadata_export_mode --value 'refresh'
'''

To import to Foreman/Satellite use the following API call:
'''
curl -H "Accept:application/json,version=2" -H "Content-Type:application/json" \
 -u admin:xxxxxx -k https://sat6.example.com/api/v2/templates/import -X POST
'''

# HOST GROUP CONFIGURATION
When using this kickstart tree, the use of host groups in Foreman simplify greatly the amount of configuration required when provisioning new hosts. Most of the configuration in the host group is host parameter settings. Depending onthe environment, it may be worth nesting host groups, so that environment common parameters are defined at the parent level, with nested child host groups defining (or overriding) parameters as required.

Many parameters have default values, so it is not necessary to define all parameters, although doing so will make it easier to see parameters that may be overridden in child host groups or even at the individial host level.
For example:

'''
root@foreman[~] # hammer hostgroup info --name LAB

Id:               1
Name:             LAB
Title:            LAB
Description:

Network:
    Subnet ipv4: VLAN4 - Lab
    Realm:       IPA.HOME.EXAMPLE.COM
    Domain:      lab.home.example.com
Operating system:
    Architecture: x86_64
Puppetclasses:

Parameters:
    auto_update => true
    enable-epel => false
    freeipa_ad_mods => true
    ignore_umask_hardening => true
    local_homedirs => true
    luks => false
    luks-passphrase => *****
    luks-tang-key1 => xxxxxxxxxxxxxxxxxxxxxxxxxxx
    luks-tang-key2 => yyyyyyyyyyyyyyyyyyyyyyyyyyy
    luks-tang-server1 => tang1.lab.home.example.com
    luks-tang-server2 => tang2.lab.home.example.com
    remote_execution_create_user => true
    remote_execution_effective_user_method => sudo
    remote_execution_ssh_user => svc-foreman-ansible
    server_gui => false
    ssh_PermitRootLogin => no
Locations:
    Home
Organizations:
    MyOrg


root@foreman[~] # hammer hostgroup info --name LAB-CENTOS7
Id:               2
Name:             LAB-CENTOS7
Title:            LAB/LAB-CENTOS7
Description:

Parent:           LAB
ComputeProfile:   Lab - PXE
Network:

Operating system:
    Operating System: CentOS 7.6.1810
    Medium:           CentOS mirror
    Partition Table:  GG-Generic
    PXE Loader:       PXELinux BIOS
Puppetclasses:

Parameters:
    extra_snippet_entry => GG-snippet_entrypoint
    ssh_PermitRootLogin => yes
Locations:
    Home
Organizations:
    MyOrg
'''



# PARAMETERS

See README-Parameters for a description of all parameters that can be defined in Foreman/Satellite for this base 'bootstrap' kickstart.

See README-Parameters_snippets for a description of all additional parameters that are used throughout the snippet-based SOE installation
