module Hound
  module Config
    class Scss < Base
      def initialize
        @linters_file_name = ".scss-lint.yml"
      end
    end
  end
end
