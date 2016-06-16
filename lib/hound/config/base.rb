module Hound
  module Config
    class Base
      def initialize(options = {})
        @options = options
        p HoundConfig.new.content
      end
    end
  end
end
