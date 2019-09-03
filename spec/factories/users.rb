FactoryBot.define do
  factory :user do
    name { 'TestUser' }
    email { 'test@sample.com' }
    introduction { 'MyText' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
