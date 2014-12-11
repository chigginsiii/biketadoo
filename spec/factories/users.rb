FactoryGirl.define do
  
  factory :user do
    email 'test@example.com'
    name  'Testy McTest'
    password 'passwurd'
    password_confirmation 'passwurd'
  end


end