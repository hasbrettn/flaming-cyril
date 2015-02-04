require 'spec_helper'

describe 'NotificationService' do

  describe '#GET /notifications/find' do
    let!( :notification ) { FactoryGirl.create(:notification) }
    before { get '/notifications/find' }

    it 'should return a list of notifications' do
      expect(last_response.body).to eq([notification].to_json)
    end

    it 'should return an ok response' do
      expect(last_response).to be_ok
    end
  end

  describe '#POST /notifications/create' do
    context 'when passed a valid notification' do
      let!(:notification) { FactoryGirl.build(:notification) }
      let(:request) { notification.to_json }

      before { post '/notification/create', request, "CONTENT_TYPE" => "application/json" }

      it 'should create a new notification' do
        expect(Notification.all.count).to eq(1)
      end

      it 'should return a JSON representation of the new Notification' do
        expect(last_response.body).to eq(notification.to_json)
      end

      it 'should return an ok response' do
        expect(last_response).to be_ok
      end
    end
  end

end