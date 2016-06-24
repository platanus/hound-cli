require "spec_helper"

describe HoundConfig do
  def set_hound_config_path(path = ".hound.yml")
    parts = [Dir.pwd, "/spec/support/assets/config", path]
    allow_any_instance_of(HoundConfig).to(
      receive(:config_file_path).and_return(File.join(parts)))
  end

  describe "#content" do
    it "returns the content of the .hound.yml file" do
      set_hound_config_path
      expect(HoundConfig.new.content).to eq(
        "scss" => { "enabled" => false },
        "ruby" => { "config_file" => ".ruby-style.yml" },
        "javascript" => { "ignore_file" => ".javascript_ignore" }
      )
    end
  end

  describe "#options_for" do
    before do
      set_hound_config_path
      @config = HoundConfig.new
    end

    it "returns content for matching linter" do
      expect(@config.options_for("ruby")).to eq("config_file" => ".ruby-style.yml")
    end

    it "returns empty hash for non matching linter" do
      expect(@config.options_for("unknown")).to eq({})
    end
  end

  describe "#enabled_for?" do
    before { @config = HoundConfig.new }

    it "returns true with undefined .hound.yml" do
      expect(@config.enabled_for?("go")).to be_truthy
    end

    context "with defined .hound.yml" do
      before { set_hound_config_path(".hound.enabled.yml") }

      it "returns true with explicit enabled option in true" do
        expect(@config.enabled_for?("ruby")).to be_truthy
      end

      it "returns true with explicit Enabled option in true" do
        expect(@config.enabled_for?("javascript")).to be_truthy
      end

      it "returns false with unknown linter" do
        expect(@config.enabled_for?("unknown")).to be_falsey
      end

      it "returns true when enabled key is not present" do
        expect(@config.enabled_for?("python")).to be_truthy
      end
    end
  end
end
