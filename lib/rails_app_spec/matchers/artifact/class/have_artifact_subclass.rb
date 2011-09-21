module RSpec::RailsApp::ArtifactClass
  module Matchers
    class HaveArtifactSubclass < RSpec::RubyContentMatchers::HaveSubclass
      def failure_message
        super
        "Expected the code to have a #{superclass} subclass called #{full_class}"
      end 

      def negative_failure_message
        super
        "Did not expect he code to have a #{superclass} subclass called #{full_class}"
      end
    end

    def have_artifact_subclass klass, superclass, type=nil
      HaveArtifactSubclass.new klass, superclass, type
    end

    def have_observer_class klass
      have_artifact_subclass klass, 'ActiveRecord::Observer', :observer
    end
#    alias_method :be_observer_class, :have_observer_class

    def have_mailer_class klass
      have_artifact_subclass klass, 'ActionMailer::Base', :mailer
    end
#    alias_method :be_mailer_class, :have_mailer_class

    def have_migration_class klass
      have_artifact_subclass klass, 'ActiveRecord::Migration'
    end
#    alias_method :be_migration_class, :have_migration_class
  end
end
