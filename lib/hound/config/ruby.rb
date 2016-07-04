module Hound
  module Config
    class Ruby < Base
      def initialize
        @linters_file_name = ".rubocop.yml"
        @file_format = :yaml
      end
    end
  end
end
