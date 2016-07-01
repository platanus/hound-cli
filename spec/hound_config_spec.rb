require "spec_helper"

describe HoundConfig do
  def stub_config_source(config_file_name)
    config_path = Dir.pwd + "/spec/support/assets/config/" + config_file_name
    allow(RestClient).to(receive(:get).and_return(File.read(config_path)))
  end

  describe "#content" do
    before { stub_config_source(".hound.remote.yml") }

    it "returns the content of the remote config file" do
      expect(HoundConfig.content).to eq(
        "scss" => { "enabled" => false },
        "ruby" => { "config_file" => ".ruby-style.yml" },
        "javascript" => { "ignore_file" => ".javascript_ignore" }
      )
    end
  end

  describe "#options_for" do
    before { stub_config_source(".hound.remote.yml") }

    it "returns content for matching linter" do
      expect(described_class.options_for("ruby")).to eq("config_file" => ".ruby-style.yml")
    end

    it "returns empty hash for non matching linter" do
      expect(described_class.options_for("unknown")).to eq({})
    end
  end

  describe "#enabled_for?" do
    before { stub_config_source(".hound.enabled.yml") }

    it "returns true with explicit enabled option in true" do
      expect(described_class.enabled_for?("ruby")).to be_truthy
    end

    it "returns true with explicit Enabled option in true" do
      expect(described_class.enabled_for?("javascript")).to be_truthy
    end

    it "returns false with unknown linter" do
      expect(described_class.enabled_for?("unknown")).to be_falsey
    end

    it "returns true when enabled key is not present" do
      expect(described_class.enabled_for?("python")).to be_truthy
    end
  end
end
