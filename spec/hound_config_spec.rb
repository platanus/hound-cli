require "spec_helper"

describe HoundConfig do
  describe "#content" do
    it "returns the content of the .hound.yml file" do
      allow(Dir).to receive(:pwd).and_return(File.join(File.dirname(__FILE__), "support/assets"))

      expect(HoundConfig.new.content).to eq(
        {
          "scss" => { "enabled" => false },
          "ruby" => { "config_file" => ".ruby-style.yml" },
          "javascript" => { "ignore_file" => ".javascript_ignore"}
        }
      )
    end
  end
end
