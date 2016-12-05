class HoundConfig
  CONFIG_FILE_REPOSITORY = "https://raw.githubusercontent.com/platanus/la-guia/master/"

  def self.content
    @@content ||= load_content
  end

  def self.enabled_for?(linter_name)
    # disabled if linter_name key does not exist in hound.yml
    return false unless content.key?(linter_name)
    options = options_for(linter_name)
    # enabled if linter_name key exists and enabled key is not defined.
    return true unless options.keys.select { |k| k.downcase === "enabled" }.any?
    # enabled "enabled" or "Enabled" keys are true.
    !!options["enabled"] || !!options["Enabled"]
  end

  def self.options_for(linter_name)
    return content[linter_name] if content.respond_to?(:key?) && content.key?(linter_name)
    Hash.new
  end

  def self.rules_url_for(linter_name)
    path_in_repo = options_for(linter_name)["config_file"].to_s
    HoundConfig::CONFIG_FILE_REPOSITORY + path_in_repo
  end

  class << self
    private

    def config_file_url
      CONFIG_FILE_REPOSITORY + ".hound.yml"
    end

    def load_content
      Hound::Parser.yaml(RestClient.get(config_file_url))
    rescue RestClient::ResourceNotFound
      inform_config_not_found(config_file_url)
      Hash.new
    end

    def inform_config_not_found(url)
      puts "config file not found in #{url}".red
    end
  end
end
