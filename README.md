This kickstart tree has been created for RHEL/CentOS 6,7 and 8 hosts provisioned by Foreman 1.15/Satellite 6.3 onwards. Several Foreman parameters changed syntax at this release level, so this tree will NOT work
with earlier Foreman/Satellite versions.

The file structure used in this Kickstart tree allows for importing into Foreman/Satellite using the
Templates plugin (Foreman 1.15 / Satellite 6.3).  The plugin will append a string to the name of all
erb files - for this kickstart I am using my organization name 'GatwardIT' as my system default prefix - if changing this string you will need to find/replace all instances within all of the erb files within this project.

The base kickstart is a common bootstrap that will kickstart any host to a consistant baseline, from which puppet or Ansible can be used to complete the build. To handle environments that still require 'legacy' kickstart snippets, an entrypoint snippet can be defined from which the legacy provisioning snippets can be defined - this keeps the common baseline, well, common.

To import to Foreman/Satellite use the following:
'''
curl -H "Accept:application/json,version=2" -H "Content-Type:application/json" -u admin:xxxxxx
-k https://sat6.example.com/api/v2/templates/import -X POST
'''


PARAMETERS

See README-Parameters for a description of all parameters that can be defined in Foreman/Satellite for this kickstart.
