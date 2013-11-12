require 'spec_helper'

describe "Virtual Pages" do 
	let!(:virtual_request) { FactoryGirl.create(:virtual_request ) }
	let!(:virtual1) { FactoryGirl.create(:virtual, creative_user: user1 ) }
 	let!(:virtual2) { FactoryGirl.create(:virtual, creative_user: user1 ) }
 	let!(:virtual3) { FactoryGirl.create(:virtual, creative_user: user2 ) }
	let(:user1) { FactoryGirl.create(:creative_user ) }
	let(:user2) { FactoryGirl.create(:creative_user ) }
	before { sign_in(user1) }

	context "when viewing user's own virtual" do

		describe "Version Control" do
			it "should apply correct version number after previous versions have been deleted"
 		end
 	end

  it "should not be editable if it has been emailed"

  context "when viewing other's virtual" do
  	before { visit virtual_request_path(virtual_request)}
  	
  	it "should not allow editing" do
  		expect(page).to have_selector("p.virtual-notice")
  	end 

  	it "should not have option to create" do
  		expect(page).not_to have_content("Create Virtual")
  	end

  	it "should show option to move" do
  		expect(page).to have_content("Move to my queue")
  	end
  
  end

end