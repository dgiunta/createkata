#!/usr/bin/env ruby -wKU

exec_file = File.expand_path(File.join(File.dirname(__FILE__), "/bin/createkata"))
binary = "/usr/local/bin/createkata"

file = File.open("/tmp/createkata", 'w')
file.puts <<-EOF
#!/usr/bin/env ruby
load File.expand_path("#{exec_file}")
EOF
file.close

system("sudo rm #{binary}") if File.exists?(binary)
system("sudo mv /tmp/createkata #{binary}")
system("sudo chmod +x #{binary}")