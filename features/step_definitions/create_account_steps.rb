Given(/^I am an unregistered user$/) do
  @user = User.new(name: 'Testy McTest', email: 'test@example.com', password: 'passwurd', password_confirmation: 'passwurd')
end

When(/^I signup for an account$/) do
  visit '/signup'
  fill_in 'Screen Name', with: @user.name
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  fill_in 'Confirm Password', with: @user.password_confirmation
  click_button('Sign Up!')
end

Then(/^a new account will be created$/) do
  expect(page).to have_content "Welcome to BikeTaDoo, #{@user.name}!"
end

Then(/^I will be logged in$/) do
  pending # look for a 'sign out' link? check to see if @current_user is user? User.name's profile?
end