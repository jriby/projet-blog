require 'rspec'
require 'active_record'
require 'rack/test'
require_relative '../sauth'
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require_relative '../bdd/database'

  include Rack::Test::Methods
