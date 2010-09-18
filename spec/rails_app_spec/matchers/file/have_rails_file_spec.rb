require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'Rails matcher: have_rails_file' do
  use_helpers :file, :controller, :permit
  
  before :each do              
    create_controller :account do
      %q{
        def index
        end
      }
    end    

    create_permit :admin do
      %q{
        license :blogging
      }
    end    

    create_permit :super_admin, :base => :admin do
      %q{
        license :user_admin
      }
    end    

    create_javascript :effects do
      '# effects '
    end    
  end

  after :each do              
    remove_controller :account
    remove_javascript :effects
  end

  it "should not have initializer :hello" do      
    root_dir.should_not have_initializer_file :hello
  end
    
  it "should have a controller :account" do      
    root_dir.should have_controller_file :account
    root_dir.should_not have_controller_file :user
  end

  it "should have a permit for :admin role" do      
    root_dir.should have_permit_file :admin
    root_dir.should have_permit :super_admin
  end

  it "should have a js :effects" do      
    root_dir.should have_javascript_file :effects
  end
end