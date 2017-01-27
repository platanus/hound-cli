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
        c.syntax = "hound rules update [#{ConfigCollection::LINTER_NAMES.join(' ')}] [options]"
        c.option "--local", "Updates rules only for local project (current path)"
        c.description = "Updates rules for enabled linters"
        c.action do |linters, options|
          linter_names = linters.empty? ? ConfigCollection::LINTER_NAMES : linters
          RulesUpdater.update(linter_names, options.local || hound_yml_exist?)
        end
      end
    end

    def hound_yml_exist?
      File.exist?(File.join(File.expand_path('.'), '.hound.yml'))
    end
  end
end
