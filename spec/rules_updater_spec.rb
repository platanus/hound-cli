require "spec_helper"

RSpec.shared_examples "get rules from url" do |linter_config|
  context "working with #{linter_config.name}" do
    def rules_for(linter_config)
      rules_assets_path = "#{Dir.pwd}/spec/support/assets/rules"
      file_path = "#{rules_assets_path}/#{linter_config.linters_file_name}"
      File.read(file_path)
    end

    let(:remote_rules) { rules_for(linter_config) }

    before do
      allow(Hound::ConfigCollection).to(
        receive(:config_instances).and_return([linter_config])
      )
      allow(RestClient).to receive(:get).and_return(remote_rules)
      allow(File).to receive(:write).and_return(true)
    end

    context "with enabled linter" do
      before do
        allow(HoundConfig).to receive(:enabled_for?).and_return(true)
        described_class.update
      end

      it "gets rules from valid url" do
        expect(RestClient).to have_received(:get).with(linter_config.rules_url).once
      end

      it "creates linter's file with files_url content" do
        expect(File).to have_received(:write).with(
          linter_config.linters_file_path, remote_rules
        ).once
      end
    end

    context "with disabled linter" do
      before do
        allow(HoundConfig).to receive(:enabled_for?).and_return(false)
        described_class.update
      end

      it "tries to return config for current linter" do
        expect(HoundConfig).to have_received(:enabled_for?).with(linter_config.name).once
      end
    end

    context "with true local option" do
      before do
        allow(HoundConfig).to receive(:enabled_for?).and_return(true)
        described_class.update([], true)
      end

      it "creates linter's file with files_url content and hound.yml" do
        expect(File).to have_received(:write).with(
          linter_config.linters_file_path(true), remote_rules
        ).once

        content = { linter_config.name => linter_config.hound_yml_config }.to_yaml
        expect(File).to have_received(:write).with(
          File.join(File.expand_path('.'), '.hound.yml'), content
        ).once
      end
    end
  end
end

describe Hound::RulesUpdater do
  describe "#update" do
    Hound::ConfigCollection.config_instances.each do |linter_config|
      include_examples("get rules from url", linter_config)
    end
  end
end
