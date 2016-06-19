module Hound
  module Lang
    class Base
      attr_reader :rules_url, :linters_file_name, :custom_rules_file_name, :file_format

      def custom_rules_initial_content
        msg = "Replace the content of this file with custom rules. \
You should avoid to use custom rules whenever possible."
        { "note" => msg }
      end

      def name
        lang_from_class
      end

      def linters_file_path
        File.join(Dir.pwd, linters_file_name)
      end

      def custom_rules_file_path
        File.join(Dir.pwd, lang.custom_rules_file_name)
      end

      private

      def lang_from_class
        lang = self.class.to_s
        lang.slice!("Hound::Lang::")
        lang.tableize.singularize
      end
    end
  end
end
