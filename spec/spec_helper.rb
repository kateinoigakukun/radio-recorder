require 'bundler'
Bundler.require

Dir[File.expand_path("../../app/*.rb", __FILE__)].each {|file| require_relative file }
Dir[File.expand_path("../../app/station/*.rb", __FILE__)].each {|file| require_relative file }
