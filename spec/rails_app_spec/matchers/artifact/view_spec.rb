require 'spec_helper'

describe 'rails view helper' do
  use_helper :view

  before :each do              
    create_view :account, :edit do
      %q{
        <h1><%= title %></h1>
      }
    end    
  end

  after :each do              
    remove_view :account, :edit
  end
    
  it "should have an account/edit view file that displays a title" do      
    root_dir.should have_view :account, :edit do |klass|
      file.should match /<%=\s*title\s*%>/
    end
    
    root_dir.should have_view_file :account, :edit do |file|
      file.should match /<%=\s*title\s*%>/
    end    
  end
end