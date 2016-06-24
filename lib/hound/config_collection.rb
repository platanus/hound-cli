module Hound
  class ConfigCollection
    LINTER_NAMES = %w{ruby eslint scss}

    def self.config_instances(linter_names = [])
      linter_names = LINTER_NAMES if linter_names.empty?
      linter_names.map do |linter|
        ensure_valid_linter(linter)
        "Hound::Config::#{linter.classify}".constantize.new
      end
    end

    class << self
      private

      def ensure_valid_linter(linter)
        if !LINTER_NAMES.include?(linter)
          raise Hound::Error::InvalidLang.new("Invalid #{linter} linter")
        end
      end
    end
  end
end
