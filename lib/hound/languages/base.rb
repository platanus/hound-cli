module Hound
  module Lang
    class Base
      attr_reader :rules_url, :file_name

      def get_rules
        if !enabled_lang?
          inform_disabled
          return false
        end

        rules = parse_rules(get_rules_from_url)
        merged = rules.deep_merge!(custom_rules)
        serialized_content = serialize_rules(merged)
        write_rules_to_file(serialized_content)
        inform_update
        true
      end

      def custom_rules
        file_path = hound_config.custom_file(lang_from_class)
        return {} unless file_path
        content = File.read(file_path)
        parse_rules(content)
      end

      def parse_rules(_content)
        {}
      end

      def serialize_rules(_rules)
        ""
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

      def inform_update
        puts "#{file_name} (#{lang_from_class} style) was updated".green
      end

      def inform_disabled
        puts "#{file_name} (#{lang_from_class} style) wasn't updated because the style was disabled on .hound.yml file".yellow
      end
    end
  end
end
