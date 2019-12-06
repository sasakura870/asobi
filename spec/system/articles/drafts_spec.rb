require 'rails_helper'

RSpec.describe '下書き一覧画面' do
  let(:main_user) { create(:user) }
  let(:sub_user) { create(:user_faker) }
  before do
    main_user.articles.create(attributes_for(:article))
    login
    visit drafts_path
  end

  context 'ログインしていない場合' do
    let(:login) {}
    it 'ログイン画面へ遷移する' do
      expect(page).to have_title 'ログイン'
    end
  end

  describe 'ログイン中' do
    let(:login) { browser_login(main_user) }

    it '下書き一覧画面へ遷移する' do
      expect(page).to have_title '下書き一覧'
    end

    context '下書きがある場合' do
      let!(:draft_article) { main_user.articles.create(attributes_for(:article, :draft)) }
      let!(:posts_article) { main_user.articles.create(attributes_for(:article)) }
      let!(:other_user_draft) { sub_user.articles.create(attributes_for(:article, :draft)) }
      before { visit drafts_path }

      it '下書きが一覧表示されている' do
        expect(page).to have_link draft_article.title
      end
      it '投稿済みの記事は表示されない' do
        expect(page).to_not have_link posts_article.title
      end
      it '他のユーザーの下書きは表示されない' do
        expect(page).to_not have_link other_user_draft.title
      end
      it '編集画面へのリンクが存在する' do
        click_on draft_article.title
        expect(page).to have_title "「#{draft_article.title}」を編集"
      end
      it '削除ボタンがある' do
        expect(page).to have_link '削除', class: 'btn-danger'
      end
      context '削除した場合' do
        it '一覧から削除される'
      end
      context '下書きが10件以上の場合' do
        before do
          9.times do
            main_user.articles.create(attributes_for(:article, :draft))
          end
          visit drafts_path
        end
        it '下書きが10件存在する' do
          within 'tbody' do
            expect(page).to have_selector 'tr', count: 10, visible: false
          end
        end
        context '投稿するボタンを押した場合' do
          before { within('header') { click_on '投稿する' } }
          it '新規投稿出来ずに下書き画面へ遷移する' do
            expect(page).to have_title '下書き一覧'
          end
          it '下書きが多すぎる旨のアラートが表示される' do
            expect(page).to have_css 'div', class: 'alert-warning'
          end
        end
      end
    end

    context '下書きがない場合' do
      it '下書きが無い旨のメッセージが表示される' do
        expect(page).to have_content 'ありません'
      end
    end
  end
end
