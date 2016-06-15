module Hound
  class Cli
    def self.run(args)
      new(args).run
    end

    def initialize(args)
      @args = args
    end

    def run
      opts = parse_args
      p opts.to_h
    end

    private

    attr_reader :args

    def parse_args
      Slop.parse do |o|
        o.string "-l", "--lang", "programming language name"
        o.string "-c", "--config-url", "style rules url for selected language"

        o.on "-v", "--version", "print the version" do
          puts "hound v#{Hound::VERSION}"
          exit
        end

        o.on "--help" do
          puts o
          exit
        end
      end
    end
  end
end
