module ControllersSharedExamples
  RSpec.shared_examples_for 'HTTPリクエストが返る' do |status|
    it { is_expected.to eq status }
  end

  RSpec.shared_examples_for 'ログイン画面へリダイレクトする' do
    it { is_expected.to redirect_to login_path }
  end

  RSpec.shared_examples_for 'マイページへリダイレクトする' do
    it { is_expected.to redirect_to user_path(request_user) }
  end

  RSpec.shared_examples_for 'confirmation画面へリダイレクトする' do
    it { is_expected.to redirect_to account_activations_path }
  end

  RSpec.shared_examples_for 'セッティング画面へリダイレクトする' do
    it { is_expected.to redirect_to settings_path }
  end

  RSpec.shared_examples_for 'モデルの総数が増える' do |model|
    it { is_expected_block.to change(model, :count).by(1) }
  end

  RSpec.shared_examples_for 'モデルの総数が変わらない' do |model|
    it { is_expected_block.to change(model, :count).by(0) }
  end

  RSpec.shared_examples_for 'モデルの総数が減る' do |model|
    it { is_expected_block.to change(model, :count).by(-1) }
  end
end