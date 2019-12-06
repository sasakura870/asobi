module Utilities
  def build_favorite(user, article)
    user.favorites.build(article_id: article.id)
  end

  def create_favorite(user, article)
    user.favorites.create(article_id: article.id)
  end

  def build_comment(user, article, content: 'test')
    user.comments.build(article_id: article.id, content: content)
  end

  def create_comment(user, article, content: 'test')
    user.comments.create(article_id: article.id, content: content)
  end

  def build_follow(following, follower)
    following.active_relationships.build(follower_id: follower.id)
  end

  def create_follow(following, follower)
    following.active_relationships.create(follower_id: follower.id)
  end

  # requests用マクロ

  def login_request(user, remember: '0')
    post login_path, params: { session: { email: user.email,
                                          password: user.password,
                                          remember: remember } }
  end

  # capybara用マクロ

  def browser_login(user)
    visit login_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_on 'ログイン'
  end

  # RSpec拡張メソッド

  def is_expected_block
    expect { subject }
  end
end
