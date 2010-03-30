$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'google_geocoding'
require 'object_factory'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  config.include(ObjectFactory::HelperMethods)
end
