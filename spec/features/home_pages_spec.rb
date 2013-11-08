require 'spec_helper'

describe "Homepage" do
  let(:creative_user) { FactoryGirl.create(:creative_user) }
  before { visit root_path }

  context "when not signed in" do
    it "should show login if no user is signed in" do
      expect(page).to have_content('Password') 
    end
  end

  context "when signed in as artist" do
    before do
      @other_creative_user = FactoryGirl.create(:creative_user)
      @virtual1 = FactoryGirl.create(:virtual_request, creative_user: creative_user, artist: creative_user)
      @virtual2 = FactoryGirl.create(:virtual_request, creative_user: creative_user, artist: creative_user)
      10.times { FactoryGirl.create(:virtual_request, creative_user: @other_creative_user) }
      sign_in(creative_user)
    end

    it "should show queue" do
      expect(page).to have_content("Welcome to Creative Queue #{creative_user.first_name}") 
    end

    it "should show creative_users virtuals" do
      expect(page).to have_content(@virtual1.company)
    end

    it "should show current virtual queue count" do
      expect(page).to have_content("My Queue (#{creative_user.virtual_requests_artist_for})")
    end

    it "should show other creative_users stats" do
      expect(page).to have_content(@other_creative_user.name)
      expect(page).to have_selector("td" , "#{@other_creative_user.virtual_requests.count}")
    end

    it "should flag revision request in queue"

  end
end
