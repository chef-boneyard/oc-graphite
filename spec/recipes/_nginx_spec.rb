require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'oc-graphite::_nginx' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  let(:vhost) { chef_run.template('/etc/nginx/sites-available/graphite') }

  it 'installs the nginx package' do
    expect(chef_run).to install_package('nginx')
  end

  it 'creates graphite vhost file' do
    expect(chef_run).to create_template('/etc/nginx/sites-available/graphite')
    expect(vhost).to notify('service[nginx]').to(:reload).delayed
  end

  it 'enables the graphite vhost' do
    expect(chef_run.link('/etc/nginx/sites-enabled/graphite')).to link_to('/etc/nginx/sites-available/graphite')
  end

  it 'should not delete the default vhost' do
    expect(chef_run).to_not delete_file('/etc/nginx/sites-enabled/default')
  end
end
