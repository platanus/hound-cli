module Hound
  module Lang
    class Ruby < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/hound/platanus/config/style_guides/platanus/ruby.yml"
        @file_name = ".rubocop.yml"
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
