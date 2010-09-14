require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'controller' do
  use_helper :file
  
  before :each do              
    create_controller :account do
      %q{
        def index
        end
      }
    end    

    create_javascript_file :effects do
      '# effects '
    end    
  end

  after :each do              
    remove_controller :account
  end

  it "should not have initializer :hello" do      
    root_dir.should_not have_initializer_file :hello
  end
    
  it "should have a controller :account" do      
    root_dir.should have_controller_file :account
  end

  it "should have a js :effects" do      
    root_dir.should have_javascript_file :effects
  end
end