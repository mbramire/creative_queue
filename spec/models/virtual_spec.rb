require 'spec_helper'

describe Virtual do
  let(:virtual) { FactoryGirl.create(:virtual) }
  let(:user) { FactoryGirl.create(:creative_user ) }

  subject { virtual }

  it { should respond_to(:document) }
  it { should respond_to(:version) }
  it { should respond_to(:recipients) }
  it { should respond_to(:creative_user_id) }
  it { should respond_to(:artist_comments) }
  it { should respond_to(:user_comments) }
  it { should respond_to(:sent) }

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
    let!(:virtual1) { FactoryGirl.create(:virtual, virtual_request_id: 1 ) }
    let!(:virtual2) { FactoryGirl.create(:virtual, virtual_request_id: 1 ) }
    it "increases version number" do
      expect(virtual1.version).to eq(1)
      expect(virtual2.version).to eq(2)
    end
  end

  describe "uploading file" do
    before(:each) do
      @virtual = FactoryGirl.create(:virtual)
      @virtual.document = File.open(File.join(Rails.root, 'spec/fake_data/sample_image.jpg'))
      @virtual.save!
    end
    it "should store document" do
      expect(@virtual).to be_valid
      expect(@virtual.document.filename).to eq 'sample_image.jpg'
    end
    it "should save file size" do
      expect(@virtual.document_file_size).to eq 26749
    end
    it "should save content type" do
      expect(@virtual.document_content_type).to eq 'image/jpeg'
    end
  end
end
