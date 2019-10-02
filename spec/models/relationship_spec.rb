require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:main_register) { create(:user) }
  let(:temporary) { create(:user, :temporary) }

  describe 'validation' do
    subject { main_register.active_relationships.build(follower_id: request_user.id) }

    context 'followed_idとfollower_idが同じ値の場合' do
      let(:request_user) { main_register }
      it_behaves_like 'validationエラー'
    end

    context 'フォロワーが仮登録ユーザーの場合' do
      let(:request_user) { temporary }
      it_behaves_like 'validationエラー'
    end
  end
end
