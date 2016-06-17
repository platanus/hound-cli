RSpec.shared_examples "get rules from url" do |language|
  describe "#get_rules" do
    before do
      # stub copy remote file process
      allow(RestClient).to receive(:get).and_return("content")
      allow(Dir).to receive(:pwd).and_return("root")
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
        expect(File).to have_received(:write).with("root/#{subject.file_name}", "content").once
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
