require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha/setup'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
Mocha::Configuration.prevent(:stubbing_non_existent_method)

require 'factory_faster'
