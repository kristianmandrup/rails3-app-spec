require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'controller' do
  use_helper :directory, :file
  
  before :each do     
    create_empty_tmp config_dir
    Dir.chdir config_dir do
      File.overwrite 'application.rb' do
        %q{
          config.root_dir = MY_ROOT
        }
      end    
    end
  end

  it "should not have initializer :hello" do      
    root_dir.should have_app_config :root_dir, 'MY_ROOT'
  end    
end