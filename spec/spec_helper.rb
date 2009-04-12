$:<< File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'spec'
require 'kata'

Spec::Matchers.create :exist do
  match do |file_path|
    File.exists?(File.expand_path(file_path))
  end
end

Spec::Matchers.create :be_directory do
  match do |file_path|
    File.directory?(File.expand_path(file_path))
  end
end

module CreateMacros
  def should_create_dirs(*dirs)
    dirs.each do |dir|
      it "should create a #{dir} directory" do
        FileUtils.should_receive(:makedirs).with(File.join(@destination, dir))
      end
    end
  end

  def should_create_files(*files)
    files.each do |file|
      it "should create #{file}" do
        File.should_receive(:open).with(File.join(@destination, file), 'w')
      end
    end
  end
end