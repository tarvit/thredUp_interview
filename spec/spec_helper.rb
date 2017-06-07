require File.expand_path('../../config/application', __FILE__)

RSpec.configure { |config|
  config.expect_with(:rspec) { |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  }

  config.mock_with(:rspec) { |mocks|
    mocks.verify_partial_doubles = true
  }

  config.shared_context_metadata_behavior = :apply_to_host_groups
}
