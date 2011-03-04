require 'spec_helper'

root_dir = RailsAssist::Directory.rails_root

describe 'model helper' do
  use_orm :mongoid  
  
  before :each do
    create_model :account do
      %q{
        # hello
        def do_it
        end
      }
    end

    create_model :person, :content => '# hello'
  end

  after :each do              
    remove_models :account, :person
  end
    
  it "should have an :account model file that contains an Account class" do 
    puts read_model :account 
    root_dir.should have_model_file :account do |file|
      file.should have_model_class :account
      file.should have_comment 'hello'
      file.should have_method :do_it
    end
    root_dir.should have_model :account do |clazz|
      puts clazz
      clazz.should have_comment 'hello'
      clazz.should have_method :do_it
    end
    root_dir.should_not have_model :user    
  end
end
