class HoundConfig
  def content
    @content ||= load_content
  end

  def enabled_for?(lang)
    # enabled if hound.yml does not exist.
    return true if content.blank?
    # disabled if hound.yml exists but lang key does not exist.
    return false unless content.has_key?(lang)
    options = options_for(lang)
    # enabled if lang key exists and enabled key is not defined.
    return true unless options.keys.select { |k| k.downcase === "enabled" }.any?
    # enabled "enabled" or "Enabled" keys are true.
    !!options["enabled"] || !!options["Enabled"]
  end

  def options_for(lang)
    return content[lang] if content.try(:has_key?, lang)
    ActiveSupport::HashWithIndifferentAccess.new
  end

  def custom_file(lang)
    file_name = options_for(lang)[:config_file]
    Dir.pwd + "/" + file_name if file_name
  end

  private

  def config_file_path
    Dir.pwd + "/.hound.yml"
  end

  def load_content
    cont = YAML::load(File.open(config_file_path))
    ActiveSupport::HashWithIndifferentAccess.new(cont)
  rescue Errno::ENOENT
    nil
  rescue Psych::SyntaxError
    raise Hound::Error::ConfigError.new("Invalid yml content in #{config_file_path}")
  end
end
