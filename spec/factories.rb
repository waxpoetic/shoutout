FactoryGirl.define do
  factory :user do
    email 'admin@example.com'
    password 'admin123'
    password_confirmation 'admin123'
  end
end
