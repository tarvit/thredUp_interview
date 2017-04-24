require 'json'
require 'base64'
require 'openssl'
require File.expand_path('../custom_config', __FILE__)

# Load 'initializers'
Dir["#{CONFIG[:config_path]}/initializers/*"].each(&method(:require))

# Load 'required' libraries
%w{errors/**/*.rb token/*.rb}.each { |lib_path|
  Dir["#{CONFIG[:lib_path]}/#{lib_path}"].each(&method(:require))
}
