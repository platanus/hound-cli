module Hound
  module Lang
    class Scss < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/hound-linters/platanus/config/scss.yml"
        @linters_file_name = ".scss-lint.yml"
        @custom_rules_file_name = ".scss-style.yml"
        @file_format = :yaml
      end
    end
  end
end
