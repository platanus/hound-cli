module Hound
  module Lang
    class Base
      attr_reader :rules_url, :file_name

      def get_rules
        content = RestClient.get(rules_url)
        File.write(file_path, content)
        true
      end

      private

      def file_path
        File.join(Dir.pwd, file_name)
      end
    end
  end
end
