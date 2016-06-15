require "spec_helper"

describe Hound::LintersInstantiator do
  subject { Hound::LintersInstantiator }

  describe "#new" do
    it "raises error passing invalid language" do
      expect { subject.new(lang: "invalid-lang") }.to(
        raise_error(Hound::Error::ConfigError))
    end
  end
end
