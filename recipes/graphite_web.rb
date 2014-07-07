#
# Cookbook Name:: oc-graphite
# Recipe:: graphite_web
#
# Copyright (C) 2014, Chef Software, Inc <legal@getchef.com>

package 'graphite-web'

template "/etc/graphite/local_settings.py.erb" do
  source "local_settings.py.erb"
  mode 0644
  owner "root"
  group "root"
end

execute 'graphite-manage syncdb' do
  user '_graphite'
  not_if { ::File.exists? '/var/lib/graphite/graphite.db' }
end

include_recipe "oc-graphite::_#{node['oc-graphite']['web']['server']}"
