#
# Cookbook Name:: oc-graphite
# Attributes:: default
#
# Copyright (C) 2014, Chef Software, Inc <legal@getchef.com>
#

default['oc-graphite']['carbon_cache']['enable'] = true

default['oc-graphite']['web']['secret_key'] = '0aed5c39507562f4519c2d47515e8221'
default['oc-graphite']['web']['time_zone'] = 'America/Los_Angeles'

default['oc-graphite']['carbon']['data_dir'] = '/var/lib/graphite/whisper/'
default['oc-graphite']['carbon']['user'] = '_graphite'
