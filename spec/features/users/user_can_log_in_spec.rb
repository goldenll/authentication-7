require "rails_helper"

# As a registered user
# When I visit '/'
# and I click on a link that says "I already have an account"
# Then I should see a login form
# When I enter my username and password
# and submit the form
# I am redirected to the home page
# and I see a welcome message with my username
# and I should no longer see the link that says "I already have an account"
# and I should no longer see the link that says "Register as a User"
# and I should see a link that says "Log out"

RSpec.describe "Logging In" do 
  it "can login with valid credentials" do 
    user = User.create(username: "funbucket", password: "test")

    visit root_path

    click_on "I already have an account"

    expect(current_path). to eq(login_path)

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome, #{user.username}")
  end

  it "cannot log in with bad credentials" do 
    user = User.create(username: "funbucket", password: "test")
    visit login_path

    fill_in :username, with: user.username
    fill_in :password, with: "bad password"

    click_on "Log In"
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end