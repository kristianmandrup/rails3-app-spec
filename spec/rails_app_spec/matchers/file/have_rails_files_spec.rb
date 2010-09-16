require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'Rails matcher: have_rails_files' do
  use_helpers :files, :file, :controller, :view
  
  before :each do                  
    create_controller :account do
      'blip'
    end    

    create_controller :person do
      'blap'
    end    

    create_javascript :effects do
      '# effects '
    end    
    
    create_javascript :noise do
      '# noise '
    end    

    create_view :person, :edit do
      '# edit person '
    end    
    
    create_view :person, :new do
      '# new person '
    end    
  end

  after :each do              
    # remove_controller :account
  end

  it "should not have a controller :account, :user" do      
    root_dir.should_not have_controller_files :account, :user
  end
    
  it "should have a controller :account, :person" do      
    root_dir.should have_controller_files :account, :person
  end

  it "should have a js :effects, :noise" do      
    root_dir.should have_javascript_files :effects, :noise
  end

  it "should not have a js files :effects, :sound" do      
    root_dir.should_not have_javascript_files :effects, :sound
  end
  
  it "should have a view :effects, :noise" do      
    root_dir.should have_view_files :edit, :new, :folder => :person
  end  
end