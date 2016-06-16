module HoundHelpers
  def set_hound_config_path(path = ".hound.yml")
    parts = [File.dirname(__FILE__), "assets", "config", path]
    allow_any_instance_of(HoundConfig).to(
      receive(:config_file_path).and_return(File.join(parts)))
  end
end

RSpec.configure do |config|
  config.include HoundHelpers
end
