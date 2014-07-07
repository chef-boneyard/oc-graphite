#
# Cookbook Name:: oc-graphite
# Recipe:: graphite_web
#
# Copyright (C) 2014, Chef Software, Inc <legal@getchef.com>

package 'graphite-carbon'

template "/etc/default/graphite-carbon" do
  source "graphite-carbon.erb"
  mode 0644
  owner "root"
  group "root"
end

template "/etc/carbon/carbon.conf" do
  source "carbon.conf.erb"
  mode 0644
  owner "root"
  group "root"
end

template "/etc/carbon/storage-schemas.conf" do
  source "storage-schemas.conf.erb"
  mode 0644
  owner "root"
  group "root"
end

template "/etc/carbon/storage-aggregation.conf" do
  source "storage-aggregation.conf.erb"
  mode 0644
  owner "root"
  group "root"
end
