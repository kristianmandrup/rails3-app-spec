# open application_file
# see if there is the config.[statement] = [expr]

require 'sugar-high/kind_of'

module RSpec::RailsApp::Content
  module Matchers
    class HaveGem
      extend Rails3::Assist::UseMacro
      use_helpers :file
    
      attr_reader :name, :version, :options

      def initialize *args
        raise ArgumentException, "First argument must name the gem" if !args.first.kind_of_label? 
        @name = args.delete_at(0)
        return if args.size == 0 || !args[1].kind_of_label? 

        @version = args.delete_at(1) 
        @options = {}

        return if args.empty?
        raise ArgumentException, "Last argument of gem statement must be a n options Hash" if !args.last.kind_of? Hash
        @options = args.last
      end

      # TODO: relative to root_path ?
      def matches?(root_path=nil)      
        content = read_gemfile
        return nil if content.empty?    
        (content =~ /gem\s+#{name_expr}#{version_expr}/)
      end

      def name_expr
        "('|\")" + name + '\1'
      end

      def version_expr
        '\s*,\s*' + "('|\")" + name + '\2' if version
      end

      def msg
        "the Gemfile to have a gem statement: gem '#{name}'#{version_txt}'"
      end
      
      def version_txt
        version ? ", '#{version}'" : ""
      end
  
      def failure_message
        "Expected #{msg}" 
      end 
    
      def negative_failure_message
        "Did not expect #{msg}" 
      end
    end
                    
    # config.autoload_paths += %W(#{Rails.root}/lib)
    # have_app_config :autoload_paths => '%W(#{Rails.root}/lib)', :op => '+='
    def have_gem *args
      HaveGem.new *args
    end
  end
end
