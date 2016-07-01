module Hound
  module Config
    class Ruby < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/la-guia/master/style/config/.rubocop.yml"
        @linters_file_name = ".rubocop.yml"
        @file_format = :yaml
      end
    end
  end
end
