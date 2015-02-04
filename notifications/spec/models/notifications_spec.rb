require 'spec_helper'

describe Notification do
  let(:described) { FactoryGirl.create(:notification) }

  it 'should respond to the expected instance methods' do
    expect(described).to respond_to(:title)
    expect(described).to respond_to(:message)
    expect(described).to respond_to(:image_url)
    expect(described).to respond_to(:email_address)
    expect(described).to respond_to(:to_json)
  end

  it 'should respond to the expected class methods' do
    expect(described_class).to respond_to(:from_json)
    expect(described_class).to respond_to(:from_hash)
  end

  describe '#to_hash' do
    it 'should return the object as hash' do
      expect(Notification.from_hash(described.to_hash)).to eq(described)
    end
  end

  describe '.from_hash' do
    let(:response) { Notification.from_hash(described.to_hash) }

    it 'response should be kind of Notification object' do
      expect(response).to be_kind_of(Notification)
    end

    it 'should return a matching Notification object' do
      expect(response).to eq(described)
    end
  end

  describe '#to_json' do

    it 'should return a json object' do
      expect(described.to_json).to eq(described.to_hash.to_json)
    end

  end

  describe '.from_json' do

    let(:response) { Notification.from_json(described.to_json) }

    it 'response should be a Notification object' do
      expect(response).to be_kind_of(Notification)
    end

    it 'should return a matching Notification object' do
      expect(response).to eq(described)
    end
  end

  describe '#==' do
    context 'when two objects have the same attributes' do
      it 'should return true' do
        expect(described).to eq(described)
      end
    end

    context 'when two objects have different attributes' do
      it 'should return false' do
        expect(described).not_to eql(FactoryGirl.build(:notification))
      end
    end
  end

  describe 'validations' do

    context 'when it has all the valid attributes' do
      it 'should create a new object' do
        expect{ FactoryGirl.create(:notification) }.to change(Notification.all, :count).by(1)
      end
    end

    context 'when an object is missing an attribute' do
      it 'should raise an exception' do
        expect{ FactoryGirl.create(:notification, :title => nil) }.to raise_error(ActiveRecord::RecordInvalid)
        expect{ FactoryGirl.create(:notification, :message => nil) }.to raise_error(ActiveRecord::RecordInvalid)
        expect{ FactoryGirl.create(:notification, :image_url => nil) }.to raise_error(ActiveRecord::RecordInvalid)
        expect{ FactoryGirl.create(:notification, :email_address => nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

end