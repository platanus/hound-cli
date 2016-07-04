module Hound
  module Config
    class Eslint < Base
      def initialize
        @linters_file_name = ".eslintrc.json"
      end
    end
  end
end
