module Hound
  class ConfigCreator
    attr_reader :config_instances, :hound_config

    def initialize(linter_names = nil)
      linter_names = [] if linter_names.blank?
      @config_instances = ConfigCollection.config_instances(linter_names)
      @hound_config = HoundConfig.new
    end

    def create
      config_data = hound_config.content || {}

      config_instances.each do |config|
        merge_linters_config(config_data, config)
        write_custom_rules(config)
      end

      write_config_file(config_data)
      inform_creation
    end

    private

    def merge_linters_config(config_data, config)
      linter_config = {
        "enabled" => true,
        "config_file" => config.custom_rules_file_name
      }

      if hound_config.options_for(config.name).empty?
        config_data[config.name] = linter_config
        return
      end

      config_data[config.name].deep_merge!(linter_config)
    end

    def write_custom_rules(config)
      content = Hound::Serializer.send(config.file_format, config.custom_rules_initial_content)
      File.write(config.custom_rules_file_path, content)
    end

    def write_config_file(config_data)
      content = Hound::Serializer.yaml(config_data)
      File.write(hound_config.config_file_path, content)
    end

    def inform_creation
      puts "#{HoundConfig::CONFIG_FILE_NAME} config file successfully created".green
    end
  end
end
