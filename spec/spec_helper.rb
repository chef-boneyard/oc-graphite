require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end

module ChefSpec::API
  module BashMatchers
    ChefSpec::Runner.define_runner_method :bash

    def run_bash(resource_name)
      ChefSpec::Matchers::ResourceMatcher.new(:bash, :run, resource_name)
    end
  end
end
