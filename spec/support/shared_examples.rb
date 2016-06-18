RSpec.shared_examples "get rules from url" do |language, file_format|
  describe "#get_rules" do
    def rules(type, language, file_format)
      file_path = Dir.pwd + "/spec/support/assets/config/rules/#{language}/#{type}.#{file_format}"
      content = File.read(file_path)
      {
        original: content,
        path: file_path,
        processed: subject.serialize_rules(subject.parse_rules(content))
      }
    end

    let(:remote_rules) { rules(:remote, language, file_format) }

    before do
      allow(RestClient).to receive(:get).and_return(remote_rules[:original])
      allow(File).to receive(:write).and_return(true)
    end

    context "with enabled lang" do
      before do
        allow_any_instance_of(HoundConfig).to receive(:enabled_for?).and_return(true)
      end

      it "gets rules from valid url" do
        subject.get_rules
        expect(RestClient).to have_received(:get).with(subject.rules_url).once
      end

      it "creates linter's file with files_url content" do
        subject.get_rules
        expect(File).to have_received(:write).with(
          "#{Dir.pwd}/#{subject.file_name}", remote_rules[:processed]).once
      end

      it "returns true after loading the rules" do
        expect(subject.get_rules).to be_truthy
      end

      context "with defined custom rules" do
        let(:custom_rules) { rules(:custom, language, file_format) }
        let(:merged_rules) { rules(:merged, language, file_format) }

        before do
          allow_any_instance_of(HoundConfig).to(
            receive(:custom_file).and_return(custom_rules[:path]))
        end

        it "creates linter's file with merged content" do
          subject.get_rules
          expect(File).to have_received(:write).with(
            "#{Dir.pwd}/#{subject.file_name}", merged_rules[:processed]).once
        end

        it "returns config file from desired lang" do
          subject.get_rules
          expect(subject.hound_config).to have_received(:custom_file).with(language).once
        end

        it "returns true after loading the rules" do
          expect(subject.get_rules).to be_truthy
        end
      end
    end

    context "with disabled lang" do
      before do
        allow_any_instance_of(HoundConfig).to receive(:enabled_for?).and_return(false)
      end

      it "returns false" do
        expect(subject.get_rules).to be_falsey
      end

      it "tries to return config for current lang" do
        subject.get_rules
        expect(subject.hound_config).to have_received(:enabled_for?).with(language).once
      end
    end
  end
end
