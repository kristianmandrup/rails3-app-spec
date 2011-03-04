require 'spec_helper'

root = RailsAssist::Directory.rails_root

describe 'Rails matcher: have_gem' do
  use_helpers :directory, :file
  
  before :each do
    puts "root: #{root_dir}"
    Dir.chdir root_dir do
      File.overwrite 'Gemfile' do
        %q{
          gem "cancan"
          gem "devise", '1.1'
        }
      end    
    end
  end

  it "should have gem 'cancan'" do      
    root.should have_gem 'cancan'
  end    

  it "should have gem 'devise' version 1.1" do      
    root.should have_gem 'cancan', '1.1'
  end    

  it "should not have gem 'devise' version 1" do      
    root.should have_gem 'devise', '1'
  end    
end