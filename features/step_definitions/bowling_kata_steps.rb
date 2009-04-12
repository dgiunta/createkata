Given /^I want to create the (.*) kata in "(.*)" directory$/ do |kata, dir|
  @name = kata
  @destination = dir
end

Given /^the destination (does|does not) already contain a "(.*)" directory$/ do |boolean, dirname|
  file = File.expand_path(File.join(@destination, dirname))
  if boolean == 'does'
    FileUtils.makedirs(file)
    file.should exist
    file.should be_directory
  else
    Dir[file, file + '*'].each do |f|
      FileUtils.rm_rf(f)
    end
    file.should_not exist
    file.should_not be_directory
  end
end

When /^I run "(.*)" with my desired destination$/ do |command|
  @create = Kata::Create.new(@name, @destination)
  @create.run
end

Then /^I should have a "(.*)" directory$/ do |dir|
  file = File.join(@destination, dir)
  file.should exist
  file.should be_directory
end

Then /^I should have a "(.*)" file$/ do |file|
  File.join(@destination, file).should exist
end