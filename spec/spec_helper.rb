$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'google_geocoding'
require 'spec'
require 'spec/autorun'

include GoogleGeocoding

Spec::Runner.configure do |config|
end
