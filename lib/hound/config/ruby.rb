module Hound
  module Config
    class Ruby < Base
      def initialize
        @linters_file_name = ".rubocop.yml"
      end
    end
  end
end
