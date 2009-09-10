$:<< File.join(File.dirname(__FILE__), '..', '..', 'lib')
require 'rubygems'
require 'spec'
require 'kata'


Spec::Matchers.define :exist do
  match do |file_path|
    File.exists?(File.expand_path(file_path))
  end
end

Spec::Matchers.define :be_directory do
  match do |file_path|
    File.directory?(File.expand_path(file_path))
  end
end
