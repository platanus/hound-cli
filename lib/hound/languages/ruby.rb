module Hound
  module Lang
    class Scss < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/hound-linters/platanus/config/scss.yml"
        @file_name = ".scss-lint.yml"
      end
    end
  end
end
