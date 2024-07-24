require 'rails_helper'

RSpec.describe BreedInfos::Seed do
  describe '.insert_all' do
    subject { described_class.insert_all }

    let(:expected_api_response) do
      [
        {
          'attributes' => {
            'name' => 'Labrador Retriever',
            'description' => 'Friendly and outgoing',
            'life' => { 'max' => 12 },
            'male_weight' => { 'max' => 32, 'min' => 29 },
            'female_weight' => { 'max' => 29, 'min' => 25 },
            'hypoallergenic' => false
          }
        },
        {
          'attributes' => {
            'name' => 'German Shepherd',
            'description' => 'Confident and courageous',
            'life' => { 'max' => 13 },
            'male_weight' => { 'max' => 40, 'min' => 35 },
            'female_weight' => { 'max' => 35, 'min' => 30 },
            'hypoallergenic' => false
          }
        }
      ]
    end

    before do
      allow(DogApi::Breeds).to receive(:fetch_all).and_return(expected_api_response)
    end

    it 'created records' do
      expect { subject }.to change(BreedInfo, :count).by(2)
    end

    context 'when there are repeated records' do
      before do
        FactoryBot.create(:breed_info)
      end

      it 'skips repeated records' do
        expect { subject }.to change(BreedInfo, :count).by(1)
      end
    end
  end
end
