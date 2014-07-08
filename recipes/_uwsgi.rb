#
# Cookbook Name:: oc-graphite
# Recipe:: _uwsgi
#
# Copyright (C) 2014, Chef Software, Inc <legal@getchef.com>

['uwsgi', 'uwsgi-plugin-python'].each do |pkg|
  package pkg
end

service 'uwsgi' do
  action [:enable, :start]
  supports :restart => true, :start => true, :stop => true, :reload => true
end

template '/etc/uwsgi/apps-available/graphite.ini' do
  source 'uwsgi-graphite.erb'
  owner 'root'
  group 'root'
  mode 0644

  notifies :reload, 'service[uwsgi]', :delayed
end

link '/etc/uwsgi/apps-enabled/graphite.ini' do
  to '/etc/uwsgi/apps-available/graphite.ini'
end
