require 'spec_helper'

describe "Virtual Request Pages" do 
  let(:admin) { FactoryGirl.create(:creative_user, admin: true) }
  before do 
  	@creative_user = FactoryGirl.create(:creative_user) 
  	@virtual = FactoryGirl.create(:virtual_request, creative_user: @creative_user)
  end

  subject { page }
  

	context "as admin" do
		before { sign_in(admin) }
		
    describe "index page" do
			before { visit virtual_requests_path }
      
      it "should show virtuals" do
      	should have_content(@virtual.company)
      end
    end

    describe "delete link" do
    	before { visit edit_virtual_request_path(@virtual) }
      it "should destroy virtual" do
      	expect { click_link "Delete Virtual" }.to change(VirtualRequest, :count).by(-1) 
      end
    end

		describe "creating virtual" do
			it "should add virtual to database" do
        visit new_virtual_request_path
        fill_in "Contact Name", with: "Doko ni arimasu ka"
        fill_in "Contact Email", with: "customer@doodoo.com"
        fill_in "Company", with: "Questionable Meats"
        fill_in "url for artwork", with: "http://www.zombo.com"
        fill_in "Comments", with: "Sa da tay"
        fill_in "Quantities", with: "69"
        fill_in "Budget Per Book (NET)", with: "999"
        fill_in "Contact Phone", with: "(800)-222-2222"
        fill_in "Quote number", with: "2"
        #fill_in "Purchase Order", with: "3"

        expect { click_button "Create Virtual" }.to change(VirtualRequest, :count).by(1)
      end
			it "should auto-assign when no artist is selected" 	
			it "should upload artwork"
			it "should e-mail virtual to client"
		end

    describe "editing virtual" do
			before { visit edit_virtual_request_path(@virtual) }
			
			it "can re-assign to a different artist"
    	it "can edit virtual fields"
    	it "should update the database" do
			  fill_in "Name", with: "New Virtual"
        fill_in "Contact Email", with: "customer@doodoo.com"
        fill_in "Company", with: "Questionable Meats"
        fill_in "url for artwork", with: "http://www.zombo.com"
        fill_in "Comments", with: "Sa da tay"
        fill_in "Quantities", with: "69"
        fill_in "Budget Per Book (NET)", with: "999"
        fill_in "Contact Phone", with: "(800)-222-2222"
        fill_in "Quote number", with: "2"
        click_on "Save Changes"
        expect(page).to have_content("Virtual request updated")
      end
    end
	end

	context "as non-admin" do
		before { sign_in(@creative_user) }
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