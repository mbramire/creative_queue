require 'spec_helper'

describe Virtual do
  let(:virtual) { FactoryGirl.create(:virtual) }
  subject { virtual }

  it { should respond_to(:document) }
  it { should respond_to(:recipients) }
  it { should respond_to(:creative_user_id) }
  it { should respond_to(:artist_comments) }
  it { should respond_to(:user_comments) }
  it { should respond_to(:sent) }
  it { should respond_to(:revision_requested) }

  it { should be_valid }

  describe "without recipients" do
    before { virtual.recipients = " " }
    it { should_not be_valid }
  end

  describe "without artist" do
    before { virtual.creative_user_id = " " }
    it { should_not be_valid }
  end

  describe "without version" do
    before { virtual.version = " " }
    it { should_not be_valid }
  end

  describe "when created" do

    it "should increment version numbers"
  end

  describe "uploading file" do
    it "should store document"
    it "should save file size"
    it "should save content type"
  end
end
