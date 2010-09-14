require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'controller' do
  use_helper :directory, :file
  
  before :each do
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
    root_dir.should have_gem 'cancan'
  end    

  it "should have gem 'devise' version 1.1" do      
    root_dir.should have_gem 'cancan', '1.1'
  end    

  it "should not have gem 'devise' version 1" do      
    root_dir.should have_gem 'devise', '1'
  end    
end