require File.join(File.dirname(__FILE__), '../spec_helper')

module Kata
  describe Create do
    extend CreateMacros
    
    before(:each) do
      @destination = File.expand_path("~/Desktop/bowling_test")
      @name = 'bowling'
      @create = Create.new(@name, @destination)
      FileUtils.stub!(:makedirs)
      File.stub!(:open)
    end
  
    it "should have a destination" do
      create = Create.new('bowling', "~/Desktop/bowling_test")
      create.destination.should == File.expand_path("~/Desktop/bowling_test")
    end
    
    it "should have a name" do
      create = Create.new('mastermind', '~/Desktop/bowling_test')
      create.name.should == 'mastermind'
    end
    
    context "calculating the last_number" do
      it "should be 0 if there's no existing directories" do
        Dir.should_receive(:[]).and_return([])
        @create.send(:last_number).should == 0
      end
      
      it "should be 1 if the last existing directory is 1" do
        Dir.should_receive(:[]).and_return(["bowling_kata_1"])
        @create.send(:last_number).should == 1
      end
      
      it "should be 2 if the last existing directory is 2" do
        Dir.should_receive(:[]).and_return(["bowling_kata_1", "bowling_kata_2"])
        @create.send(:last_number).should == 2
      end
    end
    
    context "running the command" do
      after(:each) do
        @create.run
      end
      
      it "should create the destination directory if it's not already created" do
        FileUtils.should_receive(:makedirs).with(@destination)
      end
  
      context "and a bowling_kata directory doesn't already exist" do
        before(:each) do
          File.should_receive(:exists?).with(File.join(@destination, 'bowling_kata')).and_return(false)
        end
      
        should_create_dirs "bowling_kata", "bowling_kata/features", 
                           "bowling_kata/features/step_definitions", 
                           "bowling_kata/features/support", 
                           "bowling_kata/lib", "bowling_kata/spec"
      
        should_create_files "bowling_kata/features/support/env.rb", "bowling_kata/spec/spec_helper.rb"
      end
    
      context "and a bowling_kata directory already exists" do
        before(:each) do
          File.should_receive(:exists?).with(File.join(@destination, 'bowling_kata')).and_return(true)
        end
      
        should_create_dirs "bowling_kata_1", "bowling_kata_1/features", 
                           "bowling_kata_1/features/step_definitions", 
                           "bowling_kata_1/features/support", 
                           "bowling_kata_1/lib", "bowling_kata_1/spec"
      
        should_create_files "bowling_kata_1/features/support/env.rb", "bowling_kata_1/spec/spec_helper.rb"
      end

      context "and a bowling_kata_1 directory already exists" do
        before(:each) do
          File.should_receive(:exists?).with(File.join(@destination, 'bowling_kata')).and_return(true)
          @create.should_receive(:last_number).and_return(1)
        end
      
        should_create_dirs "bowling_kata_2", "bowling_kata_2/features", 
                           "bowling_kata_2/features/step_definitions", 
                           "bowling_kata_2/features/support", 
                           "bowling_kata_2/lib", "bowling_kata_2/spec"
      
        should_create_files "bowling_kata_2/features/support/env.rb", "bowling_kata_2/spec/spec_helper.rb"
      end
    end
    
    context "creating files" do
      before(:each) do
        @contents = "contents"
        @file = "test.txt"
        @create.stub!(:code_directory).and_return(File.expand_path("/tmp/Desktop"))
      end
      
      it "should have the proper contents" do
        @create.send(:create_file, @file, @contents)
        File.open(File.expand_path("~/Desktop/test.txt"))
      end
      
      after(:each) do
        FileUtils.rm_rf(File.expand_path("/tmp/Desktop/test.txt"))
      end
    end
  end  
end
