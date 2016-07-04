module Hound
  module Config
    class Tslint < Base
      def initialize
        @linters_file_name = "tslint.json"
        @file_format = :json
      end
    end
  end
end
