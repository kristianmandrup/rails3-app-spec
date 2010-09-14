require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'controller' do
  use_helper :directory
  
  before :each do              
    create_empty_tmp :controller    
    create_empty_tmp :locale    
  end

  it "should have a rails dirs :locale and :controller" do      
    root_dir.should have_rails_dirs :locale, :controller
  end
end