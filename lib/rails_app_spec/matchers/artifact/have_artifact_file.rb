module RSpec::RailsApp::ArtifactFile  
  module Matchers
    
    (::RailsAssist.artifacts - [:view]).each do |name|
      class_eval %{
        def have_#{name}_file relative
          have_rails_artifact_file relative, :#{name}
        end
        alias_method :contain_#{name}_file, :have_#{name}_file
      }
    end
    
    def have_view_file folder, action= :show, view_ext='html.erb'
      arg = {:folder => folder, :action => action, :view_ext => view_ext}
      have_rails_file arg, :view
    end
    alias_method :contain_view_file, :have_view_file
  end
end   

 