This kickstart tree has been created for RHEL/CentOS 6/7/8 and Fedora 29+ hosts provisioned by Foreman 1.15/Satellite 6.3 onwards. Several Foreman parameters changed syntax at this release level, so this tree will NOT work
with earlier Foreman/Satellite versions.

The file structure used in this Kickstart tree allows for importing into Foreman/Satellite using the
TemplateSync plugin (Foreman 1.15 / Satellite 6.3).  The plugin can append a prefix to the name of all
erb files, however for this kickstart I am NOT making use of this. The artifacts in the repository have unique names for my installation and use 'GG' as their prefix - if changing this string you will need to find/replace all instances within all of the erb files within this project.

The base kickstart is a common bootstrap that will kickstart any host to a consistant baseline, from which puppet or Ansible can be used to complete the build. To handle environments that still require 'legacy' kickstart snippets, an entrypoint snippet can be defined from which the legacy provisioning snippets can be defined - this keeps the common baseline, well, common.

To import to Foreman/Satellite use the following API call:
'''
curl -H "Accept:application/json,version=2" -H "Content-Type:application/json" -u admin:xxxxxx
-k https://sat6.example.com/api/v2/templates/import -X POST
'''


# PARAMETERS

See README-Parameters for a description of all parameters that can be defined in Foreman/Satellite for this base 'bootstrap' kickstart.

See README-Parameters_snippets for a description of all additional parameters that are used throughout the snippet-based SOE installation
