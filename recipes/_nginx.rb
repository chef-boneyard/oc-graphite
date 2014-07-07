package 'nginx'

default['oc-graphite']['_uwsgi']['listen_ip'] = '127.0.0.1'
default['oc-graphite']['_uwsgi']['listen_ip'] = '8081'
include_recipe 'oc-graphite::_uwsgi'

service 'nginx' do
  action [:enable, :start]
  supports :restart => true, :start => true, :stop => true, :reload => true
end

template '/etc/nginx/sites-available/graphite' do
  source 'nginx-graphite.erb'
  owner 'root'
  group 'root'
  mode 0644

  notifies :reload, 'service[nginx]', :delayed
end

link '/etc/nginx/sites-available/graphite' do
  to '/etc/nginx/sites-enabled/graphite'
end

if node['oc-graphite']['_nginx']['disable_default_vhost']
  file '/etc/nginx/sites-enabled/default' do
    action :delete
  end

  notifies :reload, 'service[nginx]', :delayed
end
