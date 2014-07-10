require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'oc-graphite::graphite_carbon' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs the graphite-carbon package' do
    expect(chef_run).to install_package('graphite-carbon')
  end

  it 'creates /etc/default/graphite-carbon' do
    expect(chef_run).to render_file('/etc/default/graphite-carbon')
  end

  it 'creates /etc/carbon/carbon.conf' do
    expect(chef_run).to render_file('/etc/carbon/carbon.conf')
  end

  it 'creates /etc/carbon/storage-schemas.conf' do
    expect(chef_run).to render_file('/etc/carbon/storage-schemas.conf')
  end

  it 'creates /etc/carbon/storage-aggregation.conf' do
    expect(chef_run).to render_file('/etc/carbon/storage-aggregation.conf')
  end
end
