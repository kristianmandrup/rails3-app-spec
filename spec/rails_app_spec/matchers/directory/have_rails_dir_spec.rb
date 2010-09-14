require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'controller' do
  use_helper :directory
  
  before :each do              
    create_empty_tmp :controller    
    create_empty_tmp :locale    
    create_controller :account do
      %q{
        def index
        end
      }
    end    
  end

  after :each do              
    remove_controller :account
  end

  it "should not have an model dir" do      
    root_dir.should_not have_model_dir
  end
    
  it "should have a controller dir" do      
    root_dir.should have_controller_dir
  end

  it "should have a locale dir" do      
    root_dir.should have_locale_dir
  end
end