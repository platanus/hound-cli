module Hound
  module Lang
    class Eslint < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/hound-eslint/master/config/.eslintrc"
        @linters_file_name = ".eslintrc.json"
        @custom_rules_file_name = ".eslint-style.json"
        @file_format = :json
      end
    end
  end
end
