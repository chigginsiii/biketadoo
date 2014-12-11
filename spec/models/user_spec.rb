require 'rails_helper'

RSpec.describe User, :type => :model do

  it 'is valid with name, email, password, and password_confirmation' do
    user = User.new(name: 'Testy', email: 'test@example.com', password: 'password', password_confirmation: 'password')
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(email: 'test@example.com', password: 'password', password_confirmation: 'password')
    expect(user).to_not be_valid
  end

  it 'is not valid without an email' do
    user = User.new(name: 'Testy', password: 'password', password_confirmation: 'password')
    expect(user).to_not be_valid
  end

  it 'is not valid with duplicate email' do
    first_user = User.create!(name: 'Testy', email: 'doop@example.com', password: 'password', password_confirmation: 'password')
    second_user = first_user.dup
    expect(second_user).to_not be_valid
  end

  it 'is not valid without password' do
    user = User.new(name: 'Testy', email: 'test@example.com', password_confirmation: 'password')
    expect(user).to_not be_valid
  end

  it 'is not valid without password_confirmation' do
    user = User.new(name: 'Testy', email: 'test@example.com', password: 'password')
    expect(user).to_not be_valid
  end
end
