module Hound
  module Config
    class Eslint < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/la-guia/master/style/config/.eslintrc.yml"
        @linters_file_name = ".eslintrc.json"
        @file_format = :json
      end
    end
  end
end
