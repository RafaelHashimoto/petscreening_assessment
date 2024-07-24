# spec/controllers/pets_controller_spec.rb
require 'rails_helper'

RSpec.describe PetsController, type: :controller do
  let(:pet)         { FactoryBot.create(:pet) }
  let(:attributes)  { { name: 'Snuffles', kind: 'Dog', breed: 'Shih Tzu', weight: 5 } }

  describe 'GET #index' do
    subject { get :index }

    before { pet }

    it 'returns a success response' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it 'returns a success response' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    subject { get :show, params: { id: pet.id } }

    it 'returns a success response' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:params) { attributes }

    subject { post :create, params: { pet: params } }

    context 'with valid parameters' do
      it 'creates a new Pet' do
        expect { subject }.to change(Pet, :count).by(1)
      end

      it 'redirects to the created pet' do
        subject
        expect(response).to redirect_to(Pet.last)
      end
    end

    context 'with invalid parameters' do
      let(:params) { attributes.except(:name) }

      it 'does not create a new pet' do
        expect { subject }.to change(Pet, :count).by(0)
      end
    end
  end

  describe 'PUT #update' do
    let(:params) { { name: 'Snowball' } }

    subject { put :update, params: { id: pet.id, pet: params } }

    context 'with valid parameters' do
      it 'changes pet name' do
        expect { subject }.to change{ pet.reload.name }
      end

      it 'redirects to the updated pet' do
        subject
        expect(response).to redirect_to(pet)
      end
    end

    context 'with invalid parameters' do
      let(:params) { { name: nil } }

      it 'does not changes pet name' do
        expect { subject }.not_to change{ pet.reload.name }
      end

    end
  end

  describe 'DELETE #destroy' do
    before { pet }

    subject { delete :destroy, params: { id: pet.id } }

    it 'returns a success response' do
      subject
      expect(response).to be_redirect
    end

    it 'decrements the number of recurds' do
      expect { subject }.to change(Pet, :count).by(-1)
    end
  end
end
