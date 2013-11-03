require 'spec_helper'

describe "Virtual Pages" do 
  let(:virtual) { FactoryGirl.create(:virtual_request) }
  let(:admin) { FactoryGirl.create(:artist, admin: true) }
  let!(:artist) { FactoryGirl.create(:artist) }
  subject { page }
  

	context "as admin" do
		before { sign_in(admin) }

		describe "delete link" do
      it "should destroy virtual" do
      	expect { click_link "delete #{virtual.company}" }.to change(VirtualRequest, :count).by(-1) 
      end
    end

    describe "index page" do
			before { visit virtual_requests_path }
      it "should show virtuals"
      	should have_content(virtual.name)

      it "should show artistname"
      	should have_content(artist.name)

      it "should show unassigned if there is no artistname"

      it "should doo doo"
    end

		describe "creating virtual" do
			it "should add virtual to database" do
        visit new_virtual_request_path
        fill_in "Name", with: "New Virtual"
        fill_in "Email", with: "customer@doodoo.com"
        fill_in "Company", with: "Questionable Meats"
        fill_in "Art URL", with: "http://www.zombo.com"
        fill_in "Comments", with: "Sa da tay"
        fill_in "Quantity", with: "69"
        fill_in "Budget", with: "999"
        fill_in "Phone", with: "(800)-222-2222"
        fill_in "Quote Number", with: "2"
        fill_in "Purchase Order", with: "3"

        expect { click_button "Create Virtual" }.to change(VirtualRequest, :count).by(1)
      end
			it "should auto-assign when no artist is selected" 	
			it "should upload artwork"
			it "should e-mail virtual to client"
		end

    describe "editing virtual" do
			before { visit edit_virtual_requests_path }
			
			it "can re-assign to a different artist"
    	it "can edit virtual fields"
    	it "should update the database" do
			  fill_in "Name", with: "New Virtual"
        fill_in "Email", with: "customer@doodoo.com"
        fill_in "Company", with: "Questionable Meats"
        fill_in "Art URL", with: "http://www.zombo.com"
        fill_in "Comments", with: "Sa da tay"
        fill_in "Quantity", with: "69"
        fill_in "Budget", with: "999"
        fill_in "Phone", with: "(800)-222-2222"
        fill_in "Quote Number", with: "2"
        fill_in "Purchase Order", with: "3"
      end
    end
	end

	context "as non-admin" do
		before { sign_in(artist) }
		it { should_not have_content("delete") }
		
		describe "creating virtual" do
		 it "should add virtual to database" 
 		 it "should auto-assign to current artist" 	
 		 it "should upload artwork"
		 it "should e-mail virtual to client"
		end

		describe "editing virtual" do
			it "cannot re-assign virtual"
			it "can edit virtual fields"
			it "should update the database"
		end
		
		describe "index page" do
      before { visit virtual_requests_path }
			it { should_not have_content("delete") }

      it "should show virtuals"

      it "should show artistname"

      it "should show unassigned if there is no artistname"
		end
	end	
end