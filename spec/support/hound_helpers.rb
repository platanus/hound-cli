module HoundHelpers
  def set_hound_config_path(namespace = nil)
    path = [File.dirname(__FILE__), "assets", "config"]
    path << namespace if namespace
    allow(Dir).to receive(:pwd).and_return(File.join(path))
  end
end

RSpec.configure do |config|
  config.include HoundHelpers
end
