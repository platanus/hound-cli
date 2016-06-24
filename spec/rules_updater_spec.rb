require "spec_helper"

describe Hound::RulesUpdater do
  describe "#update" do
    subject { Hound::RulesUpdater.new }
    include_examples("get rules from url", Hound::Config::Ruby.new, "yml")
    include_examples("get rules from url", Hound::Config::Scss.new, "yml")
    include_examples("get rules from url", Hound::Config::Eslint.new, "json")
  end
end
