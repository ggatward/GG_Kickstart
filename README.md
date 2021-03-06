
This kickstart tree has been created for RHEL/CentOS 6/7/8 and Fedora 29+ hosts provisioned by Foreman 1.15/Satellite 6.3 onwards. Several Foreman parameters changed syntax at this release level, so this tree will NOT work with earlier Foreman/Satellite versions.

The base kickstart is a common bootstrap that will kickstart any host to a consistant baseline, from which puppet or Ansible can be used to complete the build. To handle environments that still require 'legacy' kickstart snippets, an entrypoint snippet can be defined from which the legacy provisioning snippets can be defined - this keeps the common baseline, well, common.

## Foreman Configuration
The file structure used in this Kickstart tree allows for importing into Foreman/Satellite using the TemplateSync plugin (Foreman 1.15 / Satellite 6.3).  The plugin can append a prefix to the name of all erb files, however for this kickstart I am NOT making use of this. The artifacts in the repository have unique names for my installation and use 'GG' as their prefix - if changing this string you will need to find/replace all instances within all of the erb files within this project.

### TemplateSync plugin
Please refer to the Foreman/Satellite installation manuals to install the template plugin.

Once installed and enabled, the following 'hammer' commands can be used to configure the TemplateSync plugin:
```
hammer settings set --name template_sync_repo --value 'https://github.com/ggatward/GG_Kickstart.git'
hammer settings set --name template_sync_branch --value 'development'
hammer settings set --name template_sync_dirname --value '/'
hammer settings set --name template_sync_associate --value 'always'
hammer settings set --name template_sync_lock --value 'false'
hammer settings set --name template_sync_metadata_export_mode --value 'refresh'
```

To import to Foreman/Satellite use the following API call, which could be used as a web-hook from a CI/CD environment:
```
# curl -k -H "Accept:application/json,version=2" -H "Content-Type:application/json" -X POST \
 -u admin:xxxxxx https://sat6.example.com/api/v2/templates/import
```

Alternatively, on the Foreman host itself you can run (as the root user):
```
# foreman-rake templates:sync
```

### Operating Systems
Once the provisioning templates have been imported, they need to be made available to the Operating System profile(s) within Foreman that they will be used with.  The 'hammer' commands below can be used to assoiciate the partition table and provisioning templates from this repository with the OS.
```
# hammer os update --title 'CentOS 7.6.1810' \
  --partition-tables 'GG-Generic,GG-Hypervisor' \
  --config-templates 'GG_Kickstart,Kickstart default PXELinux' \
  --provisioning-templates 'GG_Kickstart,Kickstart default PXELinux'
```


### Host Groups
When using this kickstart tree, the use of host groups in Foreman simplify greatly the amount of configuration required when provisioning new hosts. Most of the configuration in the host group is host parameter settings. Depending onthe environment, it may be worth nesting host groups, so that environment common parameters are defined at the parent level, with nested child host groups defining (or overriding) parameters as required.

Many parameters have default values, so it is not necessary to define all parameters, although doing so will make it easier to see parameters that may be overridden in child host groups or even at the individial host level.
For example:

```
root@foreman[~] # hammer hostgroup create --name 'GG-SOE' \
  --architecture 'x86_64' \
  --locations 'Home' \
  --organizations 'MyOrg' \
  --realm 'IPA.HOME.EXAMPLE.COM' \
  --group-parameters-attributes "
      name=auto_update\, parameter_type=boolean\, value=true, \
      name=enable-epel\, parameter_type=boolean\, value=false, \
      name=freeipa_ad_mods\, parameter_type=boolean\, value=true, \
      name=ignore_umask_hardening\, parameter_type=boolean\, value=true, \
      name=local_homedirs\, parameter_type=boolean\, value=true, \
      name=luks\, parameter_type=boolean\, value=false, \
      name=luks-passphrase\, parameter_type=string\, value='ChangeMe'\, hidden_value=true, \
      name=luks-tang-key1\, parameter_type=string\, value='xxxxxxxxxxxxxxxxxxxxxxxxxxx'\, hidden_value=true, \
      name=luks-tang-key2\, parameter_type=string\, value='yyyyyyyyyyyyyyyyyyyyyyyyyyy'\, hidden_value=true, \
      name=luks-tang-server1\, parameter_type=string\, value='tang1.core.home.example.com', \
      name=luks-tang-server2 \, parameter_type=string\, value='tang2.core.home.example.com', \
      name=ntp-server \, parameter_type=string\, value='ntp1.core.home.example.com', \
      name=remote_execution_create_user\, parameter_type=boolean\, value=true, \
      name=remote_execution_effective_user_method\, parameter_type=string\, value='sudo', \
      name=remote_execution_ssh_user\, parameter_type=string\, value='svc-foreman-ansible', \
      name=server_gui\, parameter_type=boolean\, value=false, \
      name=ssh_PermitRootLogin\, parameter_type=string\, value='no', \
      name=time-zone\, parameter_type=string\, value='Australia/Sydney', \
      name=extra_snippet_entry\, parameter_type=string\, value='GG-snippet_entrypoint', \
      name=subscription_manager\, parameter_type=boolean\, value=true, \
      name=subscription_manager_username\, parameter_type=string\, value='user@redhat.com', \
      name=subscription_manager_password\, parameter_type=string\, value='ChangeMe'\, hidden_value=true \
      "

root@foreman[~] # hammer hostgroup create --name 'LAB' \
  --parent 'GG-SOE' \
  --domain 'lab.home.example.com' \
  --locations 'Home' \
  --organizations 'MyOrg' \
  --subnet 'VLAN4 - Lab' \
  --group-parameters-attributes "
      name=luks\, parameter_type=boolean\, value=false, \
      name=luks-tang-key1\, parameter_type=string\, value='xxxxxxxxxxxxxxxxxxxxxxxxxxx'\, hidden_value=true, \
      name=luks-tang-key2\, parameter_type=string\, value='yyyyyyyyyyyyyyyyyyyyyyyyyyy'\, hidden_value=true, \
      name=luks-tang-server1\, parameter_type=string\, value='tang1.lab.home.example.com', \
      name=luks-tang-server2 \, parameter_type=string\, value='tang2.lab.home.example.com', \
      name=ssh_PermitRootLogin\, parameter_type=string\, value='yes' \
      "

root@foreman[~] # hammer hostgroup create --name 'CENTOS7' \
  --parent 'GG-SOE/LAB' \
  --locations 'Home' \
  --organizations 'MyOrg' \
  --compute-resource 'oVirt' \
  --compute-profile 'Lab - PXE' \
  --operatingsystem 'CentOS 7.6.1810' \
  --medium 'CentOS mirror' \
  --partition-table 'GG-Generic' \
  --pxe-loader 'PXELinux BIOS' \
  --group-parameters-attributes "
      name=auto_update\, parameter_type=boolean\, value=false \
      "

```

It may be further necessary to associate the kickstart template specifically with these host groups if multiple kickstart templates are used in the Foreman environment.
```
# hammer template combination create --provisioning-template 'GG_Kickstart' --hostgroup-title 'LAB/LAB-CENTOS7'
```

We can also ensure that Foreman uses the PXE templates delivered in this project by default by setting the global defaults.
```
# hammer settings set --name global_PXELinux --value 'GG-PXELinux global default'
# hammer settings set --name local_boot_PXELinux --value 'GG-PXELinux default local boot'
```
Don't forget to rebuild the default PXE templates if this is done :-)

## Parameters

See [README-Parameters](README-Parameters.md) for a description of all parameters that can be defined in Foreman/Satellite for this base 'bootstrap' kickstart.

See [README-Parameters_snippets](README-Parameters_snippets.md) for a description of all additional parameters that are used throughout the snippet-based SOE installation
