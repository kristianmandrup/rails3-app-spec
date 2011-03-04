require 'spec_helper'

root_dir = RailsAssist::Directory.rails_root

describe 'Rails matcher: have_rails_dir' do
  use_helpers :directory, :app, :controller
  
  before :each do              
    create_empty_tmp :controller    
    create_empty_tmp :locale
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