# open application_file
# see if there is the config.[statement] = [expr]

module RSpec::RailsApp::Content
  module Matchers
    class HaveAppConfig
      extend Rails3::Assist::UseMacro
      use_helpers :file
    
      attr_reader :left_side, :right_side, :operator

      def initialize statement_hash
        @left_side, @right_side = *statement.first
        @operator = statement.last[:op] || '='
      end

      # TODO: relative to root_path ?
      def matches?(root_path=nil)      
        content = read_application_file
        return nil if content.empty?
      
        ls, rs, op = escape_all(left_side, right_side, operator)
        (content =~ /config.#{ls}\s*#{op}\s*#{rs}/)
      end

      def escape_all *texts
        texts.map{|t| Regexp.escape(t) }
      end

      def msg
        "there to be the Application config statement '#{left_side} #{operator} #{right_side}' in config/application.rb"
      end
  
      def failure_message
        "Expected #{msg}" 
      end 
    
      def negative_failure_message
        super
        "Did not expect #{msg}" 
      end
    end
                    
    # config.autoload_paths += %W(#{Rails.root}/lib)
    # have_app_config :autoload_paths => '%W(#{Rails.root}/lib)', :op => '+='
    def have_app_config statement_hash
      HaveAppConfig.new statement_hash
    end
  end
end
