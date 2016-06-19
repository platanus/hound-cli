require "spec_helper"

describe Hound::RulesUpdater do
  describe "#update" do
    subject { Hound::RulesUpdater.new }
    include_examples("get rules from url", Hound::Lang::Ruby.new, "yml")
    include_examples("get rules from url", Hound::Lang::Scss.new, "yml")
    include_examples("get rules from url", Hound::Lang::Eslint.new, "json")
  end
end
