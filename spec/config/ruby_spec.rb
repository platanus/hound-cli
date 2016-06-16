require "spec_helper"

describe Hound::Config::Ruby do
  describe "#options" do
    before do
      set_hound_config_path("ruby/.hound.valid.yml")
      @conf = Hound::Config::Ruby.new
    end

    it "returns options for linter's lang" do
      expect(@conf.config).to eq(
        "config_file" => ".ruby-style.yml",
        "enabled" => true
      )
    end
  end

  describe "#enabled" do
    before do
      set_hound_config_path("ruby/.hound.valid.yml")
      @conf = Hound::Config::Ruby.new
    end

    it "returns enabled state for linter's lang" do
      expect(@conf.enabled).to be_truthy
    end
  end
end
