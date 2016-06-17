module Hound
  module Lang
    class Eslint < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/hound-eslint/master/config/.eslintrc"
        @file_name = ".eslintrc.json"
      end

      def parse_rules(content)
        Hound::Parser.json(content)
      end

      def serialize_rules(rules)
        Hound::Serializer.json(rules)
      end
    end
  end
end
