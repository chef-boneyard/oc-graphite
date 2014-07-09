#
# Cookbook Name:: oc-graphite
# Attributes:: default
#
# Copyright (C) 2014, Chef Software, Inc <legal@getchef.com>
#

default['oc-graphite']['carbon_cache']['enable'] = true

default['oc-graphite']['carbon']['data_dir'] = '/var/lib/graphite/whisper/'
default['oc-graphite']['carbon']['user'] = '_graphite'

default['oc-graphite']['web']['secret_key'] = '0aed5c39507562f4519c2d47515e8221'
default['oc-graphite']['web']['time_zone'] = 'America/Los_Angeles'
default['oc-graphite']['web']['server'] = 'uwsgi'
# This does not update after initial setup
default['oc-graphite']['web']['seed_password'] = 'changeme'

# These defaults are over riddent in the _nginx recipe
default['oc-graphite']['uwsgi']['listen_ip']   = '0.0.0.0'
default['oc-graphite']['uwsgi']['listen_port'] = 8080

default['oc-graphite']['nginx']['disable_default_vhost'] = false
# The template will use the host's FQDN unless this attribute is set
default['oc-graphite']['nginx']['hostname'] = nil
