require 'spec_helper'

describe 'oc-graphite::graphite_carbon' do
  describe process('carbon-cache') do
    it { should be_running }
  end
end
