require 'rspec-puppet'
require 'webmock/rspec'
require 'coco'

RSpec.configure do |config|
  config.mock_with :rspec
end
require 'puppetlabs_spec_helper/module_spec_helper'

def stub_default_config
  allow(Nexus3::Config).to receive(:read_config).and_return({
      nexus_base_url: 'http://example.com',
      nexus_script_api_path: '/service/rest/v1/script/',
      admin_username: 'foobar',
      admin_password: 'secret',
      health_check_retries: 1,
      health_check_timeout: 10,
      can_delete_repositories: true,
    })
end

def stub_default_config_and_healthcheck
  stub_default_config
  # healthcheck
  stub_request(:get, 'http://example.com/service/rest/v1/script/').
      with(headers: {'Accept'=>'application/json', 'Authorization'=>'Basic Zm9vYmFyOnNlY3JldA==', 'Content-Type'=>'application/json'}).
      to_return(status: 403)
end
