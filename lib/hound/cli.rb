module Hound
  class Cli
    include Commander::Methods

    def run
      program :name, "Hound"
      program :version, Hound::VERSION
      program :description, "CLI to generate style rules"

      define_configure_cmd
      define_update_cmd

      run!
    end

    private

    def define_update_cmd
      command :update do |c|
        c.syntax = "hound update"

        c.action do
          LangCollection.language_instances.each(&:get_rules)
        end
      end
    end

    def define_configure_cmd
      command :configure do |c|
        c.syntax = "hound configure"
        c.option "--langs ARRAY", Array, "Languages to include in .hound.yml"

        c.action do |_args, options|
          ConfigCreator.new(options.langs).create
        end
      end
    end
  end
end
