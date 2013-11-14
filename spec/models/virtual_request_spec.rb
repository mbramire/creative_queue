require 'spec_helper'

describe VirtualRequest do
  let(:virtual) { FactoryGirl.create(:virtual_request) }
  subject { virtual }

  it { should respond_to(:contact_name) }
  it { should respond_to(:contact_email) }
  it { should respond_to(:contact_phone) }
  it { should respond_to(:company) }
  it { should respond_to(:quantity) }
  it { should respond_to(:budget) }
  it { should respond_to(:art) }
  it { should respond_to(:art_website) }
  it { should respond_to(:due_date) }
  it { should respond_to(:artist_id) } 
  it { should respond_to(:comments)  }
  it { should respond_to(:creative_user_id) }
  it { should respond_to(:priority) }
  it { should respond_to(:purchase_order) }
  it { should respond_to(:user_id) }
  it { should respond_to(:revision_requested) }

  it { should be_valid }

  describe "without contact name" do
    before { virtual.contact_name = " " }
    it { should_not be_valid }
  end

  describe "without company" do
    before { virtual.company = " " }
    it { should_not be_valid }
  end

  describe "without contact email" do
    before { virtual.contact_email = " " }
    it { should_not be_valid }
  end

  describe "without budget" do
    before { virtual.budget = " " }
    it { should_not be_valid }
  end

  describe "without quantities" do
    before { virtual.quantity = " " }
    it { should_not be_valid }
  end

  describe "without due date" do
    before { virtual.due_date = " " }
    it { should_not be_valid }
  end

  describe "without art file or art url" do 
    before do 
      virtual.art = nil 
      virtual.art_website = " "
    end
    it { should_not be_valid }
  end

  describe "without phone number" do
    before { virtual.contact_phone = " " }
    it { should_not be_valid }
  end

  describe "when destroyed" do
    it "should destroy virtuals attached"
  end
  
  describe "when created" do
    before do
      @user = FactoryGirl.create(:user, email: virtual.contact_email)
      virtual.apply_user
    end

    it "should assign a user_id that matches the contact_email if one exists" do
      expect(virtual.user_id).to eq(@user.id)
    end

    describe "with no artist selected" do
      it "should be given to the artist with the lowest virtual count"
    end
  end
end
