RSpec.configure do |config|
  config.include RSpec::RailsApp::File::Matchers
  config.include RSpec::RailsApp::Directory::Matchers
  config.include RSpec::RailsApp::Content::Matchers
  config.include RSpec::RailsApp::Artifact::Matchers
  config.include RSpec::RailsApp::ArtifactClass::Matchers
  config.include RSpec::RailsApp::ArtifactFile::Matchers
end
