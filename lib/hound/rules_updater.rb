module Hound
  module RulesUpdater
    extend self

    def update(linter_names = [])
      ConfigCollection.config_instances(linter_names).each do |linter_config|
        get_rules(linter_config)
      end
    end

    private

    def get_rules(linter_config)
      if !HoundConfig.enabled_for?(linter_config.name)
        inform_disabled(linter_config)
        return
      end

      rules = get_rules_from_url(linter_config)
      return unless rules
      write_linters_file(linter_config, rules)
      inform_update(linter_config)
    end

    def get_rules_from_url(linter_config)
      RestClient.get(linter_config.rules_url)
    rescue RestClient::ResourceNotFound
      inform_rules_not_found(linter_config)
    end

    def write_linters_file(linter_config, rules)
      File.write(linter_config.linters_file_path, rules)
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
