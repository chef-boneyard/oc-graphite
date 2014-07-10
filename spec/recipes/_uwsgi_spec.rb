require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'oc-graphite::_uwsgi' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs the uwsgi packages' do
    expect(chef_run).to install_package('uwsgi')
    expect(chef_run).to install_package('uwsgi-plugin-python')
  end

  it 'starts and enables the uwsgi service' do
    expect(chef_run).to enable_service('uwsgi')
    expect(chef_run).to start_service('uwsgi')
  end

  it 'creates the graphite uwsgi host' do
    expect(chef_run).to create_template('/etc/uwsgi/apps-available/graphite.ini').with(
      :user => 'root',
      :group => 'root'
    )
  end

  it 'enables the graphite vhost' do
    expect(chef_run.link('/etc/uwsgi/apps-enabled/graphite.ini')).to link_to('/etc/uwsgi/apps-available/graphite.ini')
  end
end
