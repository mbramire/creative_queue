require 'spec_helper'

describe "Artist Pages"  do
  let(:admin) { FactoryGirl.create(:artist, admin: true) }
  let!(:artist) { FactoryGirl.create(:artist) }
  subject { page }
  
  context "as admin" do
    before { sign_in(admin) }

    describe "index page" do
      before { visit artists_path }

      it "should display all artists" do
        should have_content(artist.name)
      end
    end

    describe "creating artist" do
      it "should add artist to database" do
        visit new_artist_path
        fill_in "Name", with: "New Artist"
        fill_in "Email", with: "newartist@email.com"
        fill_in "Password", with: "secret"
        fill_in "Confirmation", with: "secret"
        expect { click_button "Create Artist" }.to change(Artist, :count).by(1)
      end
    end

    describe "profile page" do
      it "should show edit button for other artists" do
        visit artist_path(artist)
        should have_content("Edit Profile")
      end
    end

    describe "edit page" do
      before { visit edit_artist_path(artist) }

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
        it "should destroy artist" do
          expect { click_link "Delete #{artist.name}" }.to change(Artist, :count).by(-1) 
        end

        it "should not allow admin to delete self" do
          visit edit_artist_path(admin)
          expect { click_link "Delete #{admin.name}" }.to change(Artist, :count).by(0)
        end
      end
    end
  end

  context "as non-admin user" do
    before { sign_in(artist) }

    it { should_not have_content("delete artist") }

    describe "creating artist" do
      it "should not be possible" do
        visit new_artist_path
        expect(current_path).to_not eq(new_artist_path)
      end
    end

    describe "profile page" do
      it "should show edit button for current user" do
        visit artist_path(artist)
        should have_content("Edit Profile")
      end

      it "should not show edit button on other artists profile" do
        visit artist_path(admin)
        should_not have_content("Edit Profile")
      end
    end

    describe "edit page" do
      it "should be accesible by current user" do
        visit edit_artist_path(artist)
        expect(current_path).to eq(edit_artist_path(artist))
      end

      it "should not be accesible if not current users" do
        visit edit_artist_path(admin)
        expect(current_path).not_to eq(edit_artist_path(admin))
      end
    end
  end
end