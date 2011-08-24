require 'spec_helper'

describe 'rails view helper' do
  use_helper :view

  before do
    create_view :account, :edit do
      %q{
        <h1><%= title %></h1>
      }
    end
  end

  after do
    # remove_view :account, :edit
  end

  describe '#have_view' do
    it "should have an account/edit view file that displays a title" do
      root_dir.should have_view :account, :edit do |klass|
        klass.should match /<%=\s*title\s*%>/
      end
    end
  end
  
  describe '#have_view_file' do
    it "should have an account/edit view file that displays a title" do
      root_dir.should have_view_file :account, :edit do |file|
        file.should match /<%=\s*title\s*%>/
      end
    end
  end
end
