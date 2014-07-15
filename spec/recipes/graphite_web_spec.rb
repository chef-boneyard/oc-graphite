require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'oc-graphite::graphite_web' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  let(:initdb) { chef_run.bash('set_up_db') }

  it 'installs the graphite-web package' do
    expect(chef_run).to install_package('graphite-web')
  end

  it 'creates scriptchangepassword.py' do
    expect(chef_run).to render_file('/usr/lib/python2.7/dist-packages/django/contrib/auth/management/commands/scriptchangepassword.py')
  end

  it 'creates the graphite directory owned by _graphite' do
    expect(chef_run).to create_directory('/var/lib/graphite').with(
      :user => '_graphite'
    )
  end

  it 'initializes the database' do
    expect(chef_run).to run_bash('set_up_db')
    expect(initdb).to notify('execute[change_admin_pass]').to(:run).delayed
  end

  it 'sets the admin password' do
    expect(chef_run).to_not run_execute('change_admin_pass').with(
      :user => '_graphite',
      :cwd => '/var/lib/graphite'
    )
  end

  it 'includes webserver recipe' do
    expect(chef_run).to include_recipe('oc-graphite::_uwsgi')
  end
end
