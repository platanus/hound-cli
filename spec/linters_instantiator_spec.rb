require "spec_helper"

describe Hound::LintersInstantiator do
  subject { Hound::LintersInstantiator }
  before { set_hound_config_path }

  describe "#new" do
    it "raises error passing invalid language" do
      expect { subject.new("invalid-lang") }.to(
        raise_error(Hound::Error::ConfigError))
    end

    it "does not raise error passing valid language" do
      expect { subject.new("ruby") }.not_to raise_error
    end
  end

  describe "#instantiate" do
    it "returns linter instances based on given lang" do
      subject::LANGUAGES.each do |lang|
        li = Hound::LintersInstantiator.new(lang)
        expect(li.instantiate).to be_a("Hound::Linter::#{lang.classify}".constantize)
      end
    end

    it "calls linter's initializer with specific options class" do
      options = { some: "param" }
      allow_any_instance_of(Hound::Config::Ruby).to(
        receive(:new).with(options).and_return(:config_instance))
      allow_any_instance_of(Hound::Linter::Ruby).to receive(:new).with(:config_instance)
      Hound::LintersInstantiator.new("ruby", options).instantiate
    end
  end
end
