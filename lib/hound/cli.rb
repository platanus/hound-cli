module Hound
  class Cli
    include Commander::Methods

    def run
      program :name, "Hound"
      program :version, Hound::VERSION
      program :description, "CLI to generate style rules"
      define_config_cmds
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

    def define_config_cmds
      ConfigCollection::LINTER_NAMES.each do |linter|
        define_config_linter_cmd(linter)
      end
    end

    def define_config_linter_cmd(linter)
      command("config #{linter}") do |c|
        c.syntax = "hound config #{linter}"
        c.description = "Creates or modifies .hound.yml with default config for #{linter} linter"
        c.action { ConfigCreator.new([linter]).create }
      end
    end
  end
end
