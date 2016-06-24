module Hound
  class ConfigCreator
    attr_reader :config_instances

    def initialize(linter_names)
      linter_names = [] if linter_names.blank?
      @config_instances = ConfigCollection.config_instances(linter_names)
    end

    def create
      config_data = config_instances.inject({}) do |hash, config|
        hash[config.name] = {
          enabled: true,
          config_file: config.custom_rules_file_name
        }

        write_custom_rules(config)
        hash
      end

      write_config_file(config_data)
      inform_creation
    end

    private

    def write_custom_rules(config)
      content = Hound::Serializer.send(config.file_format, config.custom_rules_initial_content)
      File.write(config.custom_rules_file_path, content)
    end

    def write_config_file(config_data)
      content = Hound::Serializer.yaml(config_data)
      File.write(HoundConfig.new.config_file_path, content)
    end

    def inform_creation
      puts "#{HoundConfig::CONFIG_FILE_NAME} config file successfully created".green
    end
  end
end
