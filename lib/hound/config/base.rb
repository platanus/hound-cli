module Hound
  module Config
    class Base
      attr_reader :linters_file_name

      def name
        name_from_class
      end

      def linters_file_path
        File.join(File.expand_path("~"), linters_file_name)
      end

      def rules_url
        HoundConfig.rules_url_for(name)
      end

      private

      def name_from_class
        self.class.name.split("::").pop.underscore
      end
    end
  end
end
