describe Hound::Lang::Eslint do
  subject { Hound::Lang::Eslint.new }

  include_examples "get rules from url", "eslint"
end
