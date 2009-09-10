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

When /^I run "(.*)"( with my desired destination)?$/ do |command, with_dest|
  @create = with_dest ? Kata::Create.new(@name, @destination) : Kata::Create.new(@name)
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

Given /^I (do|don't) have a github repo specified$/ do |boolean|
  @repo = boolean == 'do' ? YAML.load("~/.katas/config.yml")["repo"] : nil
end

Given /^I (have|haven't) cloned the repo yet|already$/ do |boolean|
  @already_cloned = boolean == 'have'
end

Then /^it should (clone|update) (my specified|the default) repo from github( to "([^\"]*)")?$/ do |action, repo, with_loc, location|
  @action = action.to_sym
  @url = repo == "the default" ? "git://github.com/dgiunta/kata_templates.git" : "git@github.com:#{@repo}.git"
  @location = location if with_loc && location
  Git.should_receive(@action).with(@url, 'templates', :path => @location || "~/.katas/templates")
end

Then /^it should copy the (.*) files to the "([^\"]*)" directory$/ do |filetype, location|
  pending
end
