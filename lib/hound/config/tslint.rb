module Hound
  module Config
    class Tslint < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/la-guia/master/style/config/tslint.json"
        @linters_file_name = "tslint.json"
        @file_format = :json
      end
    end
  end
end
