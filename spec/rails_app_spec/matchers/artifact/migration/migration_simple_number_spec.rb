require 'spec_helper'

# Rails3::Migration::Assist.orm = :active_record

describe 'migration' do 
  # use_orm :active_record
  use_helpers :app, :migration

  before :each do              
    remove_migration :create_account        
    
    create_migration :create_account do
      %q{  def self.up
  end
  
  def self.down
  end}
    end    
  end

  after :each do              
    remove_migration :create_account
  end
    
  it "should have an create_account_migration file that contains an index method and two inserted comments" do
    existing_migration_file_name = existing_file_name :create_account, :migration
    FileUtils.mv existing_migration_file_name, existing_migration_file_name.gsub(/\d+_/, '001_')

    insert_into_migration :create_account, :content => '# hello'
    insert_into_migration :create_account do
      '# goodbye'
    end
    read_migration(:create_account).should have_comment 'hello'
    puts read_migration(:create_account)

    # puts migration_file_name :create_account

    root_dir.should have_migration :create_account

    root_dir.should have_migration :create_account do |migration_file|
      migration_file.should have_class_method :up
      migration_file.should have_comment 'hello'
      migration_file.should have_comment 'goodbye'
    end
  end
end