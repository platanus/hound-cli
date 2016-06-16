class HoundConfig
  def content
    @content ||= load_content
  end

  def enabled_for?(lang)
    return false unless content.has_key?(lang)
    options = options_for(lang)
    return true unless options.keys.select { |k| k.downcase == "enabled" }.any?
    !!options["enabled"] || !!options["Enabled"]
  end

  def options_for(lang)
    content[lang] || ActiveSupport::HashWithIndifferentAccess.new
  end

  private

  def config_file_path
    Dir.pwd + "/.hound.yml"
  end

  def load_content
    cont = YAML::load(File.open(config_file_path))
    ActiveSupport::HashWithIndifferentAccess.new(cont)
  rescue Errno::ENOENT
    raise Hound::Error::ConfigError.new("Missing .hound.yml in #{Dir.pwd}")
  rescue Psych::SyntaxError
    raise Hound::Error::ConfigError.new("Invalid yml content in #{config_file_path}")
  end
end
