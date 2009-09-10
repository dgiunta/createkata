#!/usr/bin/env ruby -wKU

class Install
  attr_reader :binary, :exec_file
  
  def initialize
    @binary = "/usr/local/bin/createkata"
    @exec_file = File.expand_path(File.join(File.dirname(__FILE__), "/bin/createkata"))
  end
  
  def run
    begin
      require 'rubygems'
      require 'fileutils'
      require 'git'
    rescue LoadError
      run_action("Installing dependencies") do
        print "  github.com/schacon/ruby-git"
        system("sudo gem install schacon-git --source=http://gems.github.com")
      end
    end
    
    if File.exists?(binary)
      run_action("Removing existing binary") do
        system("sudo rm #{binary}")
      end
    end

    run_action("Installing new binary to /usr/local/bin/createkata") do
      create_tmp_binary
      system("sudo mv /tmp/createkata #{binary}")
    end

    run_action("Making binary executable") do
      system("sudo chmod +x #{binary}")
    end
  end
  
  private

  def create_tmp_binary
    file = File.open("/tmp/createkata", 'w')
    file.puts tmp_binary_contents.gsub(/^[ \t]+/, '')
    file.close
  end
  
  def tmp_binary_contents
    <<-EOF
    #!/usr/bin/env ruby

    load "#{exec_file}"
    EOF
  end

  def run_action(string, &block)
    print string + ": "
    block.call
    print "[ DONE ]\n"
  end
end

Install.new.run