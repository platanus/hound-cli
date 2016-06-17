module Hound
  class LangCollection
    LANGS = %w{ruby eslint scss}

    def self.language_instances
      LANGS.map { |lang| "Hound::Lang::#{lang.classify}".constantize.new }
    end
  end
end
