require 'spec_helper'

describe 'observer helper' do
  use_helper :observer

  before :each do              
    create_observer :account
  end

  after :each do              
    # remove_observer :account
  end
    
  it "should have an :account observer file that contains an AccountObserver class" do
    # root_dir.should have_observer_file :account do |file|
    #   file.should have_observer_class :account
    # end
    root_dir.should have_observer :account
  end
end