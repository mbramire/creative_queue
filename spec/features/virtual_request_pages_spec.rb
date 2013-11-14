require 'spec_helper'

describe "Virtual Request Pages" do 
  before do
    @creative_user = FactoryGirl.create(:creative_user) 
    @virtual_request = FactoryGirl.create(:virtual_request, creative_user: @creative_user, artist: @creative_user)
    sign_in(@creative_user) 
  end
  
  subject { page }
  
  describe "creating virtual" do
    it "should add virtual to database" do
      visit new_virtual_request_path
      fill_in "Contact Name", with: "Troy McClure"
      fill_in "Contact Email", with: "customer@doodoo.com"
      fill_in "End Client", with: "Questionable Meats"
      fill_in "url for artwork", with: "http://www.zombo.com"
      fill_in "Comments", with: "Sa da tay"
      fill_in "Quantities", with: "69"
      fill_in "Budget Per Book (NET)", with: "999"
      fill_in "Contact Phone", with: "(800)-222-2222"
     #fill_in "Purchase Order", with: "3"

      expect { click_button "Create Virtual" }.to change(VirtualRequest, :count).by(1)
    end
  end

  describe "auto-assigning" do
    before(:each) do
      @other_artist = FactoryGirl.create(:creative_user)
      10.times { FactoryGirl.create(:virtual_request, artist: @creative_user) }
      visit edit_virtual_request_path(@virtual_request)
    end

    it "should assign to artist with lowest number of virtual requests" do
      select("auto-assign", :from => "Artist")
      click_on "Save Changes"
      expect(@virtual_request.artist).to eq(@creative_user) #this passes when it should not, @virtual_request should re-assign to someone else
      expect(@virtual_request.artist).to eq(@other_artist)
    end
  end  

  it "should e-mail virtual to client"


  describe "index page" do
    before { visit virtual_requests_path }
    
    it "should show virtuals" do
      should have_content(@virtual_request.company)
    end
  end

  describe "delete link" do
    before { visit edit_virtual_request_path(@virtual_request) }
    it "should destroy virtual" do
      expect { click_link "Delete Virtual" }.to change(VirtualRequest, :count).by(-1) 
    end
  end


  describe "editing virtual" do
    before(:each) do 
      @second_user = FactoryGirl.create(:creative_user) 
      visit edit_virtual_request_path(@virtual_request) 
    end

    it "can re-assign to a different artist" do
      select(@second_user.name, :from => "Artist")
      click_on "Save Changes" 
      expect(page).to have_content(@second_user.name)
    end

    it "should update the database" do
      fill_in "Name", with: "Waylon Smithers"
      fill_in "Contact Email", with: "customer@doodoo.com"
      fill_in "End Client", with: "Questionable Meats"
      fill_in "url for artwork", with: "http://www.zombo.com"
      fill_in "Comments", with: "Sa da tay"
      fill_in "Quantities", with: "69"
      fill_in "Budget Per Book (NET)", with: "999"
      fill_in "Contact Phone", with: "(800)-222-2222"
      click_on "Save Changes"
      expect(page).to have_content("Virtual request updated")
    end
  end
end