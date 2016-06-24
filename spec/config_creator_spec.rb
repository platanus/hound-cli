require "spec_helper"

describe Hound::ConfigCreator do
  describe "#create" do
    include_examples("create config files", Hound::Config::Ruby.new)
    include_examples("create config files", Hound::Config::Scss.new)
    include_examples("create config files", Hound::Config::Eslint.new)
  end
end
