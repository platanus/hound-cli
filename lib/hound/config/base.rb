module Hound
  module Config
    class Base
      attr_reader :config, :enabled

      def initialize(options = {})
        @options = options
        hound_config = HoundConfig.new
        lang = lang_from_class
        @enabled = hound_config.enabled_for?(lang)
        @config = hound_config.options_for(lang)
      end

      private

      def lang_from_class
        lang = self.class.to_s
        lang.slice!("Hound::Config::")
        lang.tableize.singularize
      end
    end
  end
end
