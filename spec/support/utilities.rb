include ApplicationHelper

def sign_in(artist)
  visit root_path
  fill_in "Email",    with: artist.email
  fill_in "Password", with: artist.password
  click_button "Sign in"
end