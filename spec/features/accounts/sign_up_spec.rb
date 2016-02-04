require 'rails_helper'

feature 'Accounts' do
  scenario 'creating an account' do
    visit root_path
    click_link "Create a new account"
    fill_in "Name", with: "Larry"
    fill_in "Email", with: "larry@example.com"
    fill_in "Password", with: "Password"
    fill_in "Password confirmation", with: "Password"
    fill_in "Subdomain", with: "test"
    click_button "Create Account"
    expect(page).to have_content("Signed in as larry@example.com")
    success_message = "Your account has been successfully created."
    expect(page).to have_content(success_message)
    expect(page.current_url).to eq("http://test.lvh.me/")
  end

  scenario "Ensure subdomain uniqueness" do
    Account.create(subdomain: "test", name: "Test")
    visit root_path
    click_link "Create a new account"
    fill_in "Name", with: "Larry"
    fill_in "Email", with: "larry@example.com"
    fill_in "Password", with: "Password"
    fill_in "Password confirmation", with: "Password"
    fill_in "Subdomain", with: "test"
    click_button "Create Account"
    expect(page.current_url).to eq('http://lvh.me/accounts')
    expect(page).to have_content("Sorry, your account could not be created.")
    subdomain_text = find('.account_subdomain .help-block').text
    expect(subdomain_text).to have_content("has already been taken")
  end
end
