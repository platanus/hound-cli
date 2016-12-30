module Hound
  module ConfigCollection
    extend self

    LINTER_NAMES = %w{ruby eslint tslint scss}

    def config_instances(linter_names = [])
      linter_names = LINTER_NAMES if linter_names.empty?
      linter_names.map do |linter|
        ensure_valid_linter(linter)
        Module.const_get("Hound::Config::#{linter.capitalize}").new
      end
    end

    private

    def ensure_valid_linter(linter)
      if !LINTER_NAMES.include?(linter)
        raise Hound::Error::InvalidLang.new("Invalid #{linter} linter")
      end
    end
  end
end
