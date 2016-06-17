describe Hound::Lang::Ruby do
  subject { Hound::Lang::Ruby.new }

  include_examples "get rules from url", "ruby"
end
