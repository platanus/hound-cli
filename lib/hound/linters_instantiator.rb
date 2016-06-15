module Hound
  class LintersInstantiator
    LANGUAGES = %w{ruby}

    def initialize(lang: nil, config_url: nil)
      @lang = ensure_valid_lang(lang)
      @config_url = config_url
    end

    private

    attr_reader :lang, :config_url

    def ensure_valid_lang(lang)
      return lang if LANGUAGES.include?(lang)
      raise Hound::Error::ConfigError.new("No linter for #{lang} language")
    end
  end
end
