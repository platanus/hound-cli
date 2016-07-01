module Hound
  class ConfigCreator
    attr_reader :config_instances

    def initialize(linter_names = nil)
      linter_names = [] if linter_names.blank?
      @config_instances = ConfigCollection.config_instances(linter_names)
    end

    def create
      config_data = HoundConfig.content || {}
      config_instances.each { |config| merge_linters_config(config_data, config) }
      write_config_file(config_data)
      inform_creation
    end

    private

    def merge_linters_config(config_data, config)
      if HoundConfig.options_for(config.name).empty?
        config_data[config.name] = { "enabled" => true }
        return
      end

      config_data[config.name].deep_merge!(linter_config)
    end

    def write_config_file(config_data)
      content = Hound::Serializer.yaml(config_data)
      File.write(HoundConfig.config_file_path, content)
    end

    def inform_creation
      puts ".hound.yml config file successfully updated".green
    end
  end
end
