module Hound
  class Cli
    include Commander::Methods

    def run
      program :name, "Hound"
      program :version, Hound::VERSION
      program :description, "CLI to generate style rules"

      add_update_cmd_definition

      run!
    end

    private

    def add_update_cmd_definition
      command :update do |c|
        c.syntax = "hound update"

        c.action do
          LangCollection.language_instances.each(&:get_rules)
        end
      end
    end
  end
end
