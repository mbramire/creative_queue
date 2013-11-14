require 'spec_helper'

describe "Artist Pages"  do
  let(:admin) { FactoryGirl.create(:creative_user, admin: true) }
  let!(:creative_user) { FactoryGirl.create(:creative_user) }
  subject { page }
  
  context "as admin" do
    before { sign_in(admin) }

    describe "index page" do
      before { visit creative_users_path }

      it "should display all artists" do
        should have_content(creative_user.name)
      end
    end

    describe "creating creative user" do
      it "should add user to database" do
        visit new_creative_user_path
        fill_in "Name", with: "New User"
        fill_in "Email", with: "newartist@email.com"
        fill_in "Password", with: "secret"
        fill_in "creative_user_phone_number", with: "6664206969"
        fill_in "Confirmation", with: "secret"
        expect { click_button "Create User" }.to change(CreativeUser, :count).by(1)
      end
    end

    describe "profile page" do
      it "should show edit button for other artists" do
        visit creative_user_path(creative_user)
        should have_content("Edit Profile")
      end
    end

    describe "edit page" do
      before { visit edit_creative_user_path(creative_user) }

      it "should update the database" do
        fill_in "Name", with: "Action Jackson"
        click_on "Save Changes"
        expect(page).to have_content("Action Jackson")
      end

      it "requires password confirmation when attempting to change" do
        fill_in "Password", with: "newpassword"
        click_on "Save Changes"
        expect(page).to have_content("error")
      end

      describe "delete link" do
        it "should destroy user" do
          expect { click_link "Delete #{creative_user.name}" }.to change(CreativeUser, :count).by(-1) 
        end

        it "should not allow admin to delete self" do
          visit edit_creative_user_path(admin)
          expect { click_link "Delete #{admin.name}" }.to change(CreativeUser, :count).by(0)
        end
      end
    end
  end

  context "as non-admin user" do
    before { sign_in(creative_user) }

    it { should_not have_content("delete user") }

    describe "creating user" do
      it "should not be possible" do
        visit new_creative_user_path
        expect(current_path).to_not eq(new_creative_user_path)
      end
    end

    describe "profile page" do
      it "should show edit button for current user" do
        visit creative_user_path(creative_user)
        should have_content("Edit Profile")
      end

      it "should not show edit button on other users profile" do
        visit creative_user_path(admin)
        should_not have_content("Edit Profile")
      end
    end

    describe "edit page" do
      it "should be accesible by current user" do
        visit edit_creative_user_path(creative_user)
        expect(current_path).to eq(edit_creative_user_path(creative_user))
      end

      it "should not be accesible if not current users" do
        visit edit_creative_user_path(creative_user)
        expect(current_path).to eq(edit_creative_user_path(creative_user))
      end
    end
  end
end