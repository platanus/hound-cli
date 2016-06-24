class HoundConfig
  CONFIG_FILE_NAME = ".hound.yml"

  def content
    @content ||= load_content
  end

  def enabled_for?(linter_name)
    # enabled if hound.yml does not exist.
    return true if content.blank?
    # disabled if hound.yml exists but linter_name key does not exist.
    return false unless content.has_key?(linter_name)
    options = options_for(linter_name)
    # enabled if linter_name key exists and enabled key is not defined.
    return true unless options.keys.select { |k| k.downcase === "enabled" }.any?
    # enabled "enabled" or "Enabled" keys are true.
    !!options["enabled"] || !!options["Enabled"]
  end

  def options_for(linter_name)
    return content[linter_name] if content.try(:has_key?, linter_name)
    Hash.new
  end

  def custom_rules_file_name(linter_name)
    file_name = options_for(linter_name)["config_file"]
    File.join(Dir.pwd, file_name) if file_name
  end

  def config_file_path
    File.join(Dir.pwd, CONFIG_FILE_NAME)
  end

  private

  def load_content
    YAML::load(File.open(config_file_path)).to_hash
  rescue Errno::ENOENT
    nil
  rescue Psych::SyntaxError
    raise Hound::Error::ConfigError.new("Invalid yml content in #{config_file_path}")
  end
end
