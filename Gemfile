source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# 今回は使用しない
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'faker'
# slimの追加
gem 'html2slim'
gem 'slim-rails'

# paginate導入
gem 'kaminari'

# 画像アップロード用(Active Storageに移行)
# gem 'carrierwave'
gem 'mini_magick'

# bulk insert用のgem
# Rails6標準のbulk insertを行うメソッドはvalidationを無視するものしかなかったため
gem 'activerecord-import', '~> 1.0', '>= 1.0.3'

# # 検索機能の導入(内部でform_forを使っていたため使用せず)
# gem 'ransack'

# カウントのキャッシュ
gem 'counter_culture'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # N+1問題の検出
  gem 'bullet'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # エラー画面をわかりやすく整形してくれる
  gem 'better_errors'
  # better_errorsの画面上にirb/pry(PERL)を表示する
  gem 'binding_of_caller'
  # solargraphインストール(system内のsolargraphを使用するように変更したためコメントアウト)
  # gem 'solargraph'
  # 送信したメールを確認するgem
  gem 'letter_opener'
  # pryの導入
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'factory_bot_rails', '~> 4.11'
  gem 'rspec-rails', '~> 3.7'
  gem 'spring-commands-rspec'
  gem 'webdrivers'
  # systemSpec内でブラウザの再起動を再現する
  gem 'show_me_the_cookies'
end

group :production do
  gem 'fog'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
