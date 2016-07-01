class HoundConfig
  CONFIG_FILE_URL = "https://raw.githubusercontent.com/platanus/la-guia/master/.hound.yml"

  def self.content
    @@content ||= load_content
    load_content
  end

  def self.enabled_for?(linter_name)
    # disabled if linter_name key does not exist in hound.yml
    return false unless content.has_key?(linter_name)
    options = options_for(linter_name)
    # enabled if linter_name key exists and enabled key is not defined.
    return true unless options.keys.select { |k| k.downcase === "enabled" }.any?
    # enabled "enabled" or "Enabled" keys are true.
    !!options["enabled"] || !!options["Enabled"]
  end

  def self.options_for(linter_name)
    return content[linter_name] if content.try(:has_key?, linter_name)
    Hash.new
  end

  class << self
    private

    def load_content
      Hound::Parser.yaml(RestClient.get(CONFIG_FILE_URL))
    end
  end
end
