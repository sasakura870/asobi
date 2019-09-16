require 'rails_helper'

RSpec.describe 'articles#index' do
  let(:main_user) { create(:user) }
  let(:sub_user) { create(:user_faker) }

  before do
    20.times do
      main_user.articles.create(attributes_for(:article))
      sub_user.articles.create(attributes_for(:article))
    end
    visit articles_path
  end

  it 'ページネーションが存在する' do
    expect(page).to have_css('ul', class: 'pagination', visible: false)
  end

  context '記事リンク' do
    let!(:draft) { main_user.articles.create(attributes_for(:article, :draft)) }

    it '記事の総数が41である' do
      expect(Article.count).to eq 41
    end

    it '最新の記事が表示される' do
      expect(page).to have_css('div',
                               class: 'card-deck',
                               id: sub_user.articles.last.id_digest)
    end

    it '下書きは表示されない' do
      expect(page).not_to have_css('div', id: draft.id_digest)
    end
  end
end