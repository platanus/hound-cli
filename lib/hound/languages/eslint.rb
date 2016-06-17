module Hound
  module Lang
    class Eslint < Base
      def initialize
        @rules_url = "https://raw.githubusercontent.com/platanus/hound-eslint/master/config/.eslintrc"
        @file_name = ".eslintrc.json"
      end
    end
  end
end
