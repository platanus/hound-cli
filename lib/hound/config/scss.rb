module Hound
  module Config
    class Scss < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/la-guia/master/style/config/.scss-lint.yml"
        @linters_file_name = ".scss-lint.yml"
        @file_format = :yaml
      end
    end
  end
end
