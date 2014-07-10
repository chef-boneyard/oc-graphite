#
# Cookbook Name:: oc-graphite
# Recipe:: graphite_web
#
# Copyright (C) 2014, Chef Software, Inc <legal@getchef.com>

package 'graphite-web'

template '/etc/graphite/local_settings.py' do
  source 'local_settings.py.erb'
  mode 0644
  owner 'root'
  group 'root'
end

cookbook_file '/usr/lib/python2.7/dist-packages/django/contrib/auth/management/commands/scriptchangepassword.py' do
  source 'scriptchangepassword.py'
  mode 0644
  owner 'root'
  group 'root'
end

directory '/var/lib/graphite' do
  owner '_graphite'
end

execute 'change_admin_pass' do
  command "graphite-manage scriptchangepassword admin #{node['oc-graphite']['web']['seed_password']}"
  user '_graphite'
  cwd '/var/lib/graphite'
  action :nothing
end

bash 'set_up_db' do
  user '_graphite'
  code <<-EOH
  echo 'start'
  graphite-manage syncdb --noinput
  graphite-manage createsuperuser --noinput --username=admin --email=paul@getchef.com
  EOH

  not_if { ::File.exists? '/var/lib/graphite/graphite.db' }
  notifies :run, 'execute[change_admin_pass]', :delayed
end

include_recipe "oc-graphite::_#{node['oc-graphite']['web']['server']}"
