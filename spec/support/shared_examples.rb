RSpec.shared_examples "get rules from url" do |lang, file_format|
  context "working with #{lang.name}" do
    def rules(type, lang, file_format)
      file_path = Dir.pwd + "/spec/support/assets/config/rules/#{lang.name}/#{type}.#{file_format}"
      content = File.read(file_path)
      parsed_content = subject.send(:parse_rules, lang, content)
      serialized_content = subject.send(:serialize_rules, lang, parsed_content)
      {
        original: content,
        path: file_path,
        processed: serialized_content
      }
    end

    let(:remote_rules) { rules(:remote, lang, file_format) }

    before do
      allow(Hound::LangCollection).to(
        receive(:language_instances).and_return([lang]))
      allow(RestClient).to receive(:get).and_return(remote_rules[:original])
      allow(File).to receive(:write).and_return(true)
    end

    context "with enabled lang" do
      before do
        allow_any_instance_of(HoundConfig).to receive(:enabled_for?).and_return(true)
      end

      it "gets rules from valid url" do
        subject.update
        expect(RestClient).to have_received(:get).with(lang.rules_url).once
      end

      it "creates linter's file with files_url content" do
        subject.update
        expect(File).to have_received(:write).with(
          "#{Dir.pwd}/#{lang.linters_file_name}", remote_rules[:processed]).once
      end

      context "with defined custom rules" do
        let(:custom_rules) { rules(:custom, lang, file_format) }
        let(:merged_rules) { rules(:merged, lang, file_format) }

        before do
          allow_any_instance_of(HoundConfig).to(
            receive(:custom_rules_file_name).and_return(custom_rules[:path]))
        end

        it "creates linter's file with merged content" do
          subject.update
          expect(File).to have_received(:write).with(
            "#{Dir.pwd}/#{lang.linters_file_name}", merged_rules[:processed]).once
        end

        it "returns config file from desired lang" do
          subject.update
          expect(subject.hound_config).to(
            have_received(:custom_rules_file_name).with(lang.name).once)
        end
      end
    end

    context "with disabled lang" do
      before do
        allow_any_instance_of(HoundConfig).to receive(:enabled_for?).and_return(false)
      end

      it "tries to return config for current lang" do
        subject.update
        expect(subject.hound_config).to have_received(:enabled_for?).with(lang.name).once
      end
    end
  end
end

RSpec.shared_examples "create config files" do |lang|
  context "working with #{lang.name}" do
    subject { Hound::ConfigCreator.new([lang.name]) }

    before do
      allow(File).to receive(:write).and_return(true)
      subject.create
    end

    it "creates config file with valid data" do
      content = Hound::Serializer.send(lang.file_format, lang.custom_rules_initial_content)
      expect(File).to have_received(:write).with(lang.custom_rules_file_path, content).once
    end

    it "creates custom rules file with valid data" do
      content = {
        lang.name => {
          enabled: true,
          config_file: lang.custom_rules_file_name
        }
      }

      content = Hound::Serializer.yaml(content)
      expect(File).to have_received(:write).with(HoundConfig.new.config_file_path, content).once
    end
  end
end
