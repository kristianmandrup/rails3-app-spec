module RSpec::RailsApp::ArtifactClass
  module Matchers    
    class HaveArtifactClass < RSpec::RubyContentMatchers::HaveClass
      def failure_message
        super                     
        puts "Content: #{content}"        
        "Expected the code to have a #{postfix} class called #{name}#{postfix}"
      end 

      def negative_failure_message
        super                                      
        puts "Content: #{content}"        
        "Did not expected there to be the #{postfix} class #{name}#{postfix}"
      end      
    end

    def have_artifact_class(klass, type=nil)
      HaveArtifactClass.new klass, type
    end
    
    def have_helper_class(klass)
      have_artifact_class klass, :helper
    end    
    alias_method :be_helper_class, :have_helper_class


    def have_controller_class(klass)
      have_artifact_class klass, :controller
    end
    alias_method :be_controller_class, :have_controller_class  

    def have_model_class(klass)
      have_artifact_class klass
    end
    alias_method :be_controller_class, :have_controller_class  

  end
end
