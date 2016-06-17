describe Hound::Lang::Ruby do
  subject { Hound::Lang::Ruby.new }

  describe "#get_rules" do
    before do
      stub_copy_remote_file_proccess
      @result = subject.get_rules
    end

    it "gets rules from valid url" do
      expect(RestClient).to have_received(:get).with(subject.rules_url).once
    end

    it "creates .rubocop.yml with files_url content" do
      expect(File).to have_received(:write).with("root/#{subject.file_name}", "content").once
    end

    it "returns true after loading the rules" do
      expect(@result).to be_truthy
    end
  end
end
