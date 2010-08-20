require 'spec_helper'

describe 'rails helper' do
  use_helper :helper

  before :each do              
    create_helper :account do
      %q{
        def help_me
        end
      }
    end    
  end

  after :each do              
    remove_helper :account
  end
    
  it "should have an account_helper file that contains an AccountHelper class with a help_me method inside" do      
    root_dir.should have_helper_file :account do |file|
      file.should have_helper_class :account do |klass|
        klass.should have_method :help_me
      end
    end

    root_dir.should have_helper :account do |klass|
      klass.should have_method :help_me
    end
  end
end