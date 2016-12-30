require "yaml"

module Hound
  module RulesUpdater
    extend self

    def update(linter_names = [], local = false)
      linter_configs = ConfigCollection.config_instances(linter_names)
      write_rules(linter_configs, local)
      write_hound_yml(linter_configs) if local
    end

    private

    def write_hound_yml(linter_configs)
      hound_config = linter_configs.inject({}) do |memo, linter_config|
        memo[linter_config.name] = linter_config.hound_yml_config
        memo
      end

      hound_yml_path = File.join(File.expand_path('.'), 'hound.yml')
      File.write(hound_yml_path, hound_config.to_yaml)
    end

    def write_rules(linter_configs, local)
      linter_configs.each do |linter_config|
        get_rules(linter_config, local)
      end
    end

    def get_rules(linter_config, local)
      if !HoundConfig.enabled_for?(linter_config.name)
        inform_disabled(linter_config)
        return
      end

      rules = get_rules_from_url(linter_config)
      return unless rules
      File.write(linter_config.linters_file_path(local), rules)
      inform_update(linter_config)
    end

    def get_rules_from_url(linter_config)
      RestClient.get(linter_config.rules_url)
    rescue RestClient::ResourceNotFound
      inform_rules_not_found(linter_config)
    end

    def inform_update(linter_config)
      puts "#{linter_config.linters_file_name} (#{linter_config.name} style) was updated".green
    end

    def inform_disabled(linter_config)
      puts "#{linter_config.linters_file_name} (#{linter_config.name} style) wasn't updated \
because the style was undefined or disabled in .hound.yml file".yellow
    end

    def inform_rules_not_found(linter_config)
      puts "rules for #{linter_config.name} not found in #{linter_config.rules_url}".red
    end
  end
end
