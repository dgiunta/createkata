module Kata
  class Create
    CUCUMBER_ENV_FILE = <<-EOF
$:<< File.join(File.dirname(__FILE__), '..', '..', 'lib')
require 'rubygems'
require 'spec/expectations'
EOF
  
    SPEC_HELPER_FILE = <<-EOF
$:<< File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'spec'
EOF
  
    attr_reader :destination, :name
  
    def initialize(name, destination)
      @name = name
      @destination = File.expand_path(destination)
    end
  
    def run
      make_dir(@destination)
      make_dir(code_directory)

      make_sub_dir('features')
      make_sub_dir('features/step_definitions')
      make_sub_dir('features/support')
      make_sub_dir('lib')
      make_sub_dir('spec')

      create_file('features/support/env.rb', CUCUMBER_ENV_FILE)
      create_file('spec/spec_helper.rb', SPEC_HELPER_FILE)
    end
  
    def code_directory
      return @code_directory if defined?(@code_directory) && !@code_directory.nil?
    
      path = if File.exists?(File.join(@destination, "#{name}_kata")) || last_number > 0
        "#{name}_kata_#{last_number + 1}"
      else
        "#{name}_kata"
      end
      @code_directory ||= File.join(@destination, path)
    end
  
    private
  
    def make_dir(dir)
      FileUtils.makedirs(dir)
    end
  
    def make_sub_dir(dir)
      make_dir(File.join(code_directory, dir))
    end
  
    def create_file(path, contents)
      File.open(File.join(code_directory, path), 'w') do |f|
        f.puts contents
      end
    end

    def last_number
      @last_number ||= Dir[File.join(@destination, 'bowling_kata_*')].collect {|dir| dir.split(/_/).last.to_i }.max || 0
    end
  end  
end
