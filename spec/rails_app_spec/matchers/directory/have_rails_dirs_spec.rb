require 'spec_helper'

root_dir = RailsAssist::Directory.rails_root

describe 'Rails matcher: have_rails_dirs' do
  use_helpers :directory, :app
  
  before :each do              
    create_empty_tmp :controller    
    create_empty_tmp :locale    
  end

  it "should have a rails dirs :locale and :controller" do      
    root_dir.should have_rails_dirs :locale, :controller
  end

  it "should not have rails dirs :locale and :model" do      
    root_dir.should_not have_rails_dirs :locale, :model
  end

  it "should not have rails dirs :locale and :model - bad array" do      
    root_dir.should_not have_rails_dirs [[:locale, :model]]
    root_dir.should_not have_rails_dirs []    
  end
end