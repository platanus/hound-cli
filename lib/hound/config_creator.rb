module Hound
  class ConfigCreator
    attr_reader :langs

    def initialize(langs)
      @langs = langs || []
    end

    def create
      p langs
      puts "TODO"
    end
  end
end
