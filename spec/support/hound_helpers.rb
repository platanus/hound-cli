module HoundHelpers
  def set_hound_config_path(path = ".hound.yml")
    parts = [File.dirname(__FILE__), "assets", "config", path]
    allow_any_instance_of(HoundConfig).to(
      receive(:config_file_path).and_return(File.join(parts)))
  end

  def stub_copy_remote_file_proccess
    allow(RestClient).to receive(:get).and_return("content")
    allow(Dir).to receive(:pwd).and_return("root")
    allow(File).to receive(:write).and_return(true)
  end
end

RSpec.configure do |config|
  config.include HoundHelpers
end
