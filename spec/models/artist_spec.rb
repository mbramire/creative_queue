require 'spec_helper'

describe Artist do

  before do
    @artist = Artist.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  subject { @artist }

  it { should respond_to(:email) }
  it { should respond_to(:name) }
  it { should respond_to(:in_queue) }
  it { should respond_to(:title) }
  it { should respond_to(:admin) }
  it { should respond_to(:virtual_requests) }

  it { should be_valid }

  its(:first_name) { should == "Example" }

  describe "when name is not present" do
    before { @artist.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @artist.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @artist.email = invalid_address
        expect(@artist).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @artist.email = valid_address
        expect(@artist).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do 
      duplicate = @artist.dup
      duplicate.email.upcase
      duplicate.save
    end

    it { should_not be_valid }
  end

  describe "virtual requests" do
    #let! necessary to initialzie virtuals right away, since they are not called in a before block
    let!(:virtual1) { FactoryGirl.create(:virtual_request, artist: @artist ) }
    let!(:virtual2) { FactoryGirl.create(:virtual_request, artist: @artist ) }

    it "should be multiple" do
      @artist.virtual_requests.count.should == 2 
    end
  end
end
