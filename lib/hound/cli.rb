module Hound
  class Cli
    include Commander::Methods

    def run
      program :name, "Hound"
      program :version, Hound::VERSION
      program :description, "CLI to generate style rules"
      define_update_cmd
      run!
    end

    private

    def define_update_cmd
      command(:update) do |c|
        c.syntax = "hound update"
        c.description = "Updates rules for enabled linters"
        c.action { RulesUpdater.new.update }
      end
    end
  end
end
