module RailsFile
  module Matcher
    module Helper  
      attr_reader :file, :type, :name  
      
      def msg
        "Rails app to have the #{type} file called #{name} at: #{file}"
      end

      def failure_message
        "Expected #{msg}"
      end

      def negative_failure_message
        "Did not expect #{msg}"
      end   
    end
  end
end