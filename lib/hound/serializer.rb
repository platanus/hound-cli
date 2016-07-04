module Hound
  class Serializer
    def self.yaml(data)
      data.to_yaml
    end

    def self.json(data)
      JSON.pretty_generate(data)
    end
  end
end
