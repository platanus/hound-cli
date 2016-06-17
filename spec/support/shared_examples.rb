RSpec.shared_examples "get rules from url" do |language, file_format|
  describe "#get_rules" do
    let(:remote_rules) { rules(:remote, language, file_format) }

    def rules(type, language, file_format)
      rules_path = Dir.pwd + "/spec/support/assets/config/rules/#{language}"
      file = File.read("#{rules_path}/#{type}.#{file_format}")
      processed_file = subject.serialize_rules(subject.parse_rules(file))
      {
        original: file,
        processed: processed_file
      }
    end

    before do
      # stub copy remote file process
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

      it "creates linter file with files_url content" do
        subject.get_rules
        expect(File).to have_received(:write).with("#{Dir.pwd}/#{subject.file_name}", remote_rules[:processed]).once
      end

      it "returns true after loading the rules" do
        expect(subject.get_rules).to be_truthy
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
