module Hound
  class LintersInstantiator
    LANGUAGES = %w{ruby}

    def initialize(lang, options = {})
      @lang = ensure_valid_lang(lang)
      @options = options
    end

    def instantiate
      config = linter_config.new(options)
      linter_class.new(config)
    end

    private

    attr_reader :lang, :options

    def ensure_valid_lang(lang)
      return lang if LANGUAGES.include?(lang)
      raise Hound::Error::ConfigError.new("No linter for #{lang} language")
    end

    def linter_class
      lang_class(:linter)
    end

    def linter_config
      lang_class(:config)
    end

    def lang_class(namespace)
      "Hound::#{namespace.to_s.classify}::#{lang.classify}".constantize
    end
  end
end
