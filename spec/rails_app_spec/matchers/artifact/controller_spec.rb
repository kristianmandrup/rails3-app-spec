require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'controller' do
  use_helper :controller
  
  before :each do              
    create_empty_tmp :controller    
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
    
  it "should have an account_controller file that contains an AccountController class with an index method inside" do      
    root_dir.should have_controller :account do |content|
      content.should have_method :index
    end

    root_dir.should have_controller_file :account do |controller_file|
      controller_file.should have_controller_class :account do |klass|
        klass.should have_method :index
      end
    end
  end
end