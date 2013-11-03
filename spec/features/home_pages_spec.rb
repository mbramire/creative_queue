require 'spec_helper'

describe "Homepage" do
  let(:artist) { FactoryGirl.create(:artist) }
  before { visit root_path }

  context "when not signed in" do
    it "should show login if no user is signed in" do
      expect(page).to have_content('Password') 
    end
  end

  context "when signed in" do
    before do
      @other_artist = FactoryGirl.create(:artist)
      @virtual1 = FactoryGirl.create(:virtual_request, artist: artist)
      @virtual2 = FactoryGirl.create(:virtual_request, artist: artist)
      10.times { FactoryGirl.create(:virtual_request, artist: @other_artist) }
      sign_in(artist)
    end

    it "should show queue" do
      expect(page).to have_content("Welcome to Creative Queue #{artist.first_name}") 
    end

    it "should show artists virtuals" do
      expect(page).to have_content(@virtual1.company)
    end

    it "should show current virtual count" do
      expect(page).to have_content("My Queue (#{artist.virtual_requests.count})")
    end

    it "should show other artists stats" do
      expect(page).to have_content(@other_artist.name)
      expect(page).to have_selector("td" , "#{@other_artist.virtual_requests.count}")
    end

    it "should flag revision request in queue"

  end
end
