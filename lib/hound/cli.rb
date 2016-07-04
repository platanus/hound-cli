module Hound
  class Cli
    include Commander::Methods

    def run
      program :name, "Hound"
      program :version, Hound::VERSION
      program :description, "CLI to generate style rules"
      define_update_cmds
      run!
    end

    private

    def define_update_cmds
      command("rules update") do |c|
        c.syntax = "hound rules updates"
        c.description = "Update rules for enabled linters"
        c.action { RulesUpdater.update }
      end

      ConfigCollection::LINTER_NAMES.each do |linter|
        define_update_linter_cmd(linter)
      end
    end

    def define_update_linter_cmd(linter)
      command("rules update #{linter}") do |c|
        c.syntax = "hound rules update #{linter}"
        c.description = "Update rules for #{linter} linter"
        c.action { RulesUpdater.update(linter) }
      end
    end
  end
end
