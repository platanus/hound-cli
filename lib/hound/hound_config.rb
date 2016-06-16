class HoundConfig
  def content
    @content ||= load_content
  end

  def config_file_path
    Dir.pwd + "/.hound.yml"
  end

  private

  def load_content
    cont = YAML::load(File.open(config_file_path))
    ActiveSupport::HashWithIndifferentAccess.new(cont)
  rescue Errno::ENOENT
    raise Hound::Error::ConfigError.new("Missing .hound.yml in #{Dir.pwd}")
  rescue Psych::SyntaxError
    raise Hound::Error::ConfigError.new("Invalid yml content in #{config_file_path}")
  end
end
