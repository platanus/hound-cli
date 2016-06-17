describe Hound::Lang::Ruby do
  subject { Hound::Lang::Ruby.new }

  describe "#get_rules" do
    before { stub_copy_remote_file_proccess }

    context "with enabled lang" do
      before do
        allow_any_instance_of(HoundConfig).to receive(:enabled_for?).and_return(true)
      end

      it "gets rules from valid url" do
        subject.get_rules
        expect(RestClient).to have_received(:get).with(subject.rules_url).once
      end

      it "creates .rubocop.yml with files_url content" do
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
        expect(subject.hound_config).to have_received(:enabled_for?).with("ruby").once
      end
    end
  end
end
