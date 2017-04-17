require 'yaml'
require 'json'
require 'base64'
require 'openssl'

# Init custom environment config
CUSTOM_CONFIG = {}

# Add project root path to environment
CUSTOM_CONFIG[:root_path] = __dir__.gsub('/config', '')

# Add project secret key to environment
secret_key_path = "#{CUSTOM_CONFIG[:root_path]}/config/secrets.yml"
CUSTOM_CONFIG[:secret_key] = YAML.load_file(File.join(secret_key_path))['JWT_SECRET']

# Make custom environment config immutable
CUSTOM_CONFIG.freeze

# Load initializers
initializers_dir = "#{CUSTOM_CONFIG[:root_path]}/config/initializers"
Dir["#{initializers_dir}/*"].each { |init_path| require(init_path) }

# Load required libraries
lib_dir = "#{CUSTOM_CONFIG[:root_path]}/lib"
%w{errors/**/*.rb token/*.rb}.each { |lib_path|
  Dir["#{lib_dir}/#{lib_path}"].each { |full_path| require(full_path) }
}
