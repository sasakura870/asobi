module ModelsSharedExamples
  RSpec.shared_examples_for 'validation通過' do
    it { is_expected.to be_valid }
  end

  RSpec.shared_examples_for 'validationエラー' do
    it { is_expected.to_not be_valid }
  end
end
