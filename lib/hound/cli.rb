module Hound
  class Cli
    def self.run(args)
      new(args).run
    end

    def initialize(args)
      @command = args.first.to_s.to_sym
    end

    def run
      LangCollection.language_instances.each(&:get_rules) if command == :update
    rescue Hound::Error::ConfigError => e
      puts e.message.red
    end

    private

    attr_reader :command
  end
end
