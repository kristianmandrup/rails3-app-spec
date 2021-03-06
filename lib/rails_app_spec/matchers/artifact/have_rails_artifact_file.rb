module RSpec::RailsApp::ArtifactFile
  module Matchers
    class HaveRailsArtifactFile
      extend RailsAssist::UseMacro
      use_helpers :file

      attr_accessor :name, :artifact_type, :artifact_name
      attr_accessor :folder, :action, :view_ext

      include ::ArtifactFile::Matcher::Helper

      def initialize(name, artifact_type = nil)
        self.artifact_type = artifact_type

        extend "RailsAssist::Artifact::#{artifact_type.to_s.camelize}".constantize

        if name.kind_of? Hash
          set_view name
          return nil
        end
        self.artifact_name = name.to_s
      end

      def matches?(root_path, &block)
        begin
          self.artifact_name = get_artifact_name
          match = File.file? artifact_name
          if block && match
            yield File.read(artifact_name)
          end
          match
        rescue
          false
        end
      end
    end

    def have_rails_artifact_file(relative, artifact_type = nil)
      HaveRailsArtifactFile.new(relative, artifact_type)
    end
    alias_method :contain_rails_artifact_file, :have_rails_artifact_file
  end
end

