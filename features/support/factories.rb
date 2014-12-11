require 'factory_girl'

FactoryGirl.define do

  factory :user do
    email 'test@example.com'
    name  'Fuquor McFuckty'
    password 'suckit'
    password_confirmation 'suckit'
  end

end