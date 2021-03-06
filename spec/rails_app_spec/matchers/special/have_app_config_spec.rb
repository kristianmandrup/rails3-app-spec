require 'spec_helper'

root_dir = RailsAssist::Directory.rails_root

describe 'Rails matcher: have_app_config' do
  use_helpers :directory, :file, :app

  before :each do
    create_empty_tmp :config
    Dir.chdir config_dir do
      File.overwrite 'application.rb' do
        %q{
          config.root_dir = MY_ROOT
        }
      end
    end
  end

  it "should not have initializer :hello" do
    root_dir.should have_app_config :root_dir => 'MY_ROOT'
  end
end
