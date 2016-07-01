module Hound
  module Config
    class Base
      attr_reader :rules_url, :linters_file_name, :file_format

      def name
        name_from_class
      end

      def linters_file_path
        File.join(Dir.pwd, linters_file_name)
      end

      private

      def name_from_class
        self.class.name.demodulize.underscore
      end
    end
  end
end
