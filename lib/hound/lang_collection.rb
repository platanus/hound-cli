module Hound
  class LangCollection
    LANGS = %w{ruby eslint scss}

    def self.language_instances(langs = [])
      langs = LANGS if langs.empty?
      langs.map do |lang|
        ensure_valid_lang(lang)
        "Hound::Lang::#{lang.classify}".constantize.new
      end
    end

    class << self
      private

      def ensure_valid_lang(lang)
        raise Hound::Error::InvalidLang.new("Invalid #{lang} lang") unless LANGS.include?(lang)
      end
    end
  end
end
