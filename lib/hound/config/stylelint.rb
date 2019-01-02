module Hound
  module Config
    class Stylelint < Base
      def initialize
        @linters_file_name = ".stylelintrc.json"
      end
    end
  end
end
