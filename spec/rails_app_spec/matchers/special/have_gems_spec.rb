require 'spec_helper'

root_dir = Rails3::Assist::Directory.rails_root

describe 'controller' do
  use_helper :directory, :file
  
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
    root_dir.should have_gems 'cancan', 'devise', 'roles'
  end    

  it "should not have gems 'cancan', 'devise', 'roles_are_us'" do      
    root_dir.should have_gems 'cancan', 'devise', 'roles_are_us'
  end    
end