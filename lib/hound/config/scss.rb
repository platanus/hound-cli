module Hound
  module Config
    class Scss < Base
      def initialize
        @linters_file_name = ".scss-lint.yml"
        @file_format = :yaml
      end
    end
  end
end
