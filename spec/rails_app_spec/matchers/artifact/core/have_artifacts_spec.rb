require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'controller' do
  use_helpers :controller, :app
  
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
    remove_controllers :account, :person
  end

  # it "should not have :controller artifact :person" do      
  #   root_dir.should_not have_artifact :person, :controller
  # end
  #   
  # it "should have an account_controller file that contains an AccountController class with an index method inside" do      
  #   root_dir.should have_artifact :account, :controller do |content|
  #     content.should have_method :index
  #   end
  # 
  #   create_controller :person do
  #     %q{
  #       def index
  #       end
  #     }
  #   end    
  # 
  #   root_dir.should have_artifacts :controller, :account, :person
  #   root_dir.should have_artifacts :controller, [:account, :person]
  # end
  
  it "should not have :controller artifacts :account and :user" do       
    root_dir.should_not have_artifacts :controller, [:account, :user]    
  end 
end