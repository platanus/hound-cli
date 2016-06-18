module Hound
  class ConfigCreator
    attr_reader :lang_instances

    def initialize(langs)
      langs = [] if langs.blank?
      @lang_instances = LangCollection.language_instances(langs)
    end

    def create
      config_data = lang_instances.inject({}) do |hash, lang|
        hash[lang.name] = {
          enabled: true,
          config_file: lang.custom_file_name
        }

        write_custom_rules(lang)
        hash
      end

      write_config_file(config_data)
      inform_creation
    end

    private

    def write_custom_rules(lang)
      path = Dir.pwd + "/" + lang.custom_file_name
      File.write(path, lang.custom_rules_content)
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
