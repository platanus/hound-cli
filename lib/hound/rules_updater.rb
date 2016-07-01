module Hound
  class RulesUpdater
    def update
      ConfigCollection.config_instances.each { |linter_config| get_rules(linter_config) }
    end

    private

    def get_rules(linter_config)
      if !HoundConfig.enabled_for?(linter_config.name)
        inform_disabled(linter_config)
        return
      end

      rules = parse_rules(linter_config, get_rules_from_url(linter_config))
      merged = rules.deep_merge!(get_custom_rules(linter_config))
      serialized_content = serialize_rules(linter_config, merged)
      write_linters_file(linter_config, serialized_content)
      inform_update(linter_config)
    end

    def get_custom_rules(linter_config)
      file_path = HoundConfig.custom_rules_file_name(linter_config.name)
      return {} unless file_path
      content = File.read(file_path)
      parse_rules(linter_config, content)
    end

    def get_rules_from_url(linter_config)
      RestClient.get(linter_config.rules_url)
    end

    def parse_rules(linter_config, content)
      Hound::Parser.send(linter_config.file_format, content)
    end

    def serialize_rules(linter_config, content)
      Hound::Serializer.send(linter_config.file_format, content)
    end

    def write_linters_file(linter_config, rules)
      File.write(linter_config.linters_file_path, rules)
    end

    def inform_update(linter_config)
      puts "#{linter_config.linters_file_name} (#{linter_config.name} style) was updated".green
    end

    def inform_disabled(linter_config)
      puts "#{linter_config.linters_file_name} (#{linter_config.name} style) wasn't updated \
because the style was disabled in .hound.yml file".yellow
    end
  end
end
