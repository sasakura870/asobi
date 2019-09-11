require 'rails_helper'

RSpec.describe 'article#show' do
  let(:main_user) { create(:user) }
  let(:main_article) { main_user.articles.create(attributes_for(:article)) }

  before do
    visit article_path(main_article.id)
  end

  it 'タイトルに記事のタイトルが含まれる' do
    expect(page).to have_title(main_article.title)
  end
end
