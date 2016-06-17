describe Hound::Lang::Scss do
  subject { Hound::Lang::Scss.new }

  include_examples "get rules from url", "scss"
end
