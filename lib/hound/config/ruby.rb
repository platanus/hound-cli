module Hound
  module Config
    class Ruby < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/hound/platanus/config/style_guides/platanus/ruby.yml"
        @linters_file_name = ".rubocop.yml"
        @custom_rules_file_name = ".ruby-style.yml"
        @file_format = :yaml
      end
    end
  end
end
