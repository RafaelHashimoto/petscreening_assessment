require 'rails_helper'
require 'net/http'

RSpec.describe DogApi::Breeds do
  describe '.fetch_all' do

    subject { described_class.fetch_all }

    let(:api_breeds_endpoint) { 'https://dogapi.dog/api/v2/breeds' }
    let(:next_page)           { 'https://dogapi.dog/api/v2/breeds?page[number]=2' }
    let(:response_body_page1) do
      {
        'data':  [{ 'id': '1', 'attributes': { 'name': 'Labrador Retriever' } }],
        'links': { 'next' => next_page }
      }.to_json
    end
    let(:response_body_page2) do
      {
        'data':  [{ 'id': '2', 'attributes': { 'name': 'German Shepherd' } }],
        'links': { }
      }.to_json
    end

    before do
      stub_request(:get, api_breeds_endpoint).to_return(body: response_body_page1)
      stub_request(:get, next_page).to_return(body: response_body_page2)
    end

    it 'fetches all breeds' do
      breeds = subject
      expect(breeds).to be_an(Array)
      expect(breeds.size).to eq(2)
      expect(breeds.first['attributes']['name']).to eq('Labrador Retriever')
      expect(breeds.last['attributes']['name']).to eq('German Shepherd')
    end

    it 'logs the requests' do
      expect(Rails.logger).to receive(:info).with("Requesting: #{api_breeds_endpoint}").ordered
      expect(Rails.logger).to receive(:info).with("Requesting: #{next_page}").ordered
      subject
    end

    context 'rate limit' do
      let(:wait_time)    { 1 }
      let(:max_requests) { 1 }

      before do
        stub_const('DogApi::Breeds::RATE_LIMITER_WAIT_TIME',          wait_time)
        stub_const('DogApi::Breeds::DOG_API_MAX_REQUESTS_PER_MINUTE', max_requests)
      end

      it 'handles rate limiting' do
        expect_any_instance_of(described_class).to receive(:sleep).with(1).exactly(:once)
        subject
      end
    end
  end
end
