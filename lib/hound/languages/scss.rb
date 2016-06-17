module Hound
  module Lang
    class Scss < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/hound-linters/platanus/config/scss.yml"
        @file_name = ".scss-lint.yml"
      end

      def parse_rules(content)
        Hound::Parser.yaml(content)
      end

      def serialize_rules(rules)
        Hound::Serializer.yaml(rules)
      end
    end
  end
end
