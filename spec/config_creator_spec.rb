require "spec_helper"

describe Hound::ConfigCreator do
  describe "#create" do
    include_examples("create config files", Hound::Lang::Ruby.new)
    include_examples("create config files", Hound::Lang::Scss.new)
    include_examples("create config files", Hound::Lang::Eslint.new)
  end
end
