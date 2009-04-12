require 'rubygems'
require 'fileutils'
Dir[File.join(File.dirname(__FILE__), 'kata/**/*.rb')].each { |f| require f }