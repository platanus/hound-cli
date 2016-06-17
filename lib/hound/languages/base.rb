module Hound
  module Lang
    class Base
      attr_reader :rules_url, :file_name

      def get_rules
        return false unless enabled_lang?
        rules = get_rules_from_url
        write_rules_to_file(rules)
        true
      end

      def hound_config
        @hound_config ||= HoundConfig.new
      end

      private

      def get_rules_from_url
        RestClient.get(rules_url)
      end

      def write_rules_to_file(rules)
        File.write(file_path, rules)
      end

      def file_path
        File.join(Dir.pwd, file_name)
      end

      def enabled_lang?
        hound_config.enabled_for?(lang_from_class)
      end

      def lang_from_class
        lang = self.class.to_s
        lang.slice!("Hound::Lang::")
        lang.tableize.singularize
      end
    end
  end
end
