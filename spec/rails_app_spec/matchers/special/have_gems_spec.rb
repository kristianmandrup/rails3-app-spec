require 'spec_helper'

root = RailsAssist::Directory.rails_root

describe 'Rails matcher: have_gems' do
  use_helpers :directory, :file

  before :each do
    Dir.chdir root_dir do
      File.overwrite 'Gemfile' do
        %q{
          gem "cancan"
          gem "devise", '1.1'
          gem "roles"
        }
      end
    end
  end

  it "should have gems 'cancan', 'devise', 'roles'" do
    root.should have_gems 'cancan', 'devise', 'roles'
  end

  it "should not have gems 'cancan', 'devise', 'roles_are_us'" do
    root.should have_gems 'cancan', 'devise', 'roles_are_us'
  end
end
