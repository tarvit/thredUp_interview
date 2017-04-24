require 'yaml'

# Init 'custom' environment config
CONFIG = {}

# Add project required 'paths' to environment
CONFIG[:root_path] = File.expand_path('../../', __FILE__)
CONFIG[:config_path] = "#{CONFIG[:root_path]}/config"
CONFIG[:lib_path] = "#{CONFIG[:root_path]}/lib"

# Add project 'secret_key' to environment
CONFIG[:secret_key] = YAML.load_file("#{CONFIG[:config_path]}/secrets.yml")['JWT_SECRET']

# Make 'custom' environment config immutable
CONFIG.freeze
