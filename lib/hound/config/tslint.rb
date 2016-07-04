module Hound
  module Config
    class Tslint < Base
      def initialize
        @linters_file_name = "tslint.json"
      end
    end
  end
end
