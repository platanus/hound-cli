module Hound
  class RulesUpdater
    def update
      LangCollection.language_instances.each { |lang| get_rules(lang) }
    end

    def hound_config
      @hound_config ||= HoundConfig.new
    end

    private

    def get_rules(lang)
      if !hound_config.enabled_for?(lang.name)
        inform_disabled(lang)
        return
      end

      rules = parse_rules(lang, get_rules_from_url(lang))
      merged = rules.deep_merge!(get_custom_rules(lang))
      serialized_content = serialize_rules(lang, merged)
      write_linters_file(lang, serialized_content)
      inform_update(lang)
    end

    def get_custom_rules(lang)
      file_path = hound_config.custom_rules_file_name(lang.name)
      return {} unless file_path
      content = File.read(file_path)
      parse_rules(lang, content)
    end

    def get_rules_from_url(lang)
      RestClient.get(lang.rules_url)
    end

    def parse_rules(lang, content)
      Hound::Parser.send(lang.file_format, content)
    end

    def serialize_rules(lang, content)
      Hound::Serializer.send(lang.file_format, content)
    end

    def write_linters_file(lang, rules)
      File.write(lang.linters_file_path, rules)
    end

    def inform_update(lang)
      puts "#{lang.linters_file_name} (#{lang.name} style) was updated".green
    end

    def inform_disabled(lang)
      puts "#{lang.linters_file_name} (#{lang.name} style) wasn't updated \
because the style was disabled on .hound.yml file".yellow
    end
  end
end
