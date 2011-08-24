require 'spec_helper'

root_dir = RailsAssist::Directory.rails_root

describe 'mailer helper' do
  load_helper :mailer

  before :each do
    create_mailer :account do
      %q{
        def mail_it!
        end
      }
    end
  end

  after :each do
    # remove_mailer :account
  end

  it "should have an account mailer file with a mail_it! method inside" do
    root_dir.should_not have_mailer :user
    root_dir.should have_mailer :account do |klass|
      klass.should have_method :mail_it!
    end

    root_dir.should have_mailer_file :account do |file|
      file.should have_mailer_class :account do |klass|
        klass.should have_method :mail_it!
      end
    end
  end
end
