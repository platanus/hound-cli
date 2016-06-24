module Hound
  module Config
    class Base
      attr_reader :rules_url, :linters_file_name, :custom_rules_file_name, :file_format

      def custom_rules_initial_content
        msg = "Replace the content of this file with custom rules. \
You should avoid to use custom rules whenever possible."
        { "note" => msg }
      end

      def name
        name_from_class
      end

      def linters_file_path
        File.join(Dir.pwd, linters_file_name)
      end

      def custom_rules_file_path
        File.join(Dir.pwd, custom_rules_file_name)
      end

      private

      def name_from_class
        self.class.name.demodulize.underscore
      end
    end
  end
end
