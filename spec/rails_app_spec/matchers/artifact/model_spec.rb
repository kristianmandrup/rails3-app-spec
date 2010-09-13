require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'model helper' do
  use_orm :active_record  

  before :each do              
    create_model :account, :content => '# hello'
  end

  after :each do              
    remove_model :account
  end
    
  it "should have an :account model file that contains an Account class" do
    root_dir.should have_model_file :account do |file|
      file.should have_model_class :account
    end
    root_dir.should have_model :account
  end
end

describe 'model helper - no ORM helper' do
  use_helper :model

  before :each do              
    remove_model :account
  end
    
  it "should not be able to create a model without including an ORM helper" do
    lambda {create_model :account}.should raise_error
  end
end