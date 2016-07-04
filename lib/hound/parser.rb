module Hound
  class Parser
    def self.yaml(content)
      YAML.safe_load(content, [Regexp])
    end
  end
end
