# frozen_string_literal: true

# KudosTransactions controller spec
require 'rails_helper'

RSpec.describe KudosTransactionsController, type: :controller do
  before :each do
    @user1 = create(:user, first_name: 'Bee', email: 'bee@bee.com')
    @user2 = create(:user, first_name: 'Cathy', email: 'cathy@cathy.com')
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(@user1)
  end

  describe '#create' do
    context 'successful post' do
      let(:params) { { receiverId: @user2.id, message: 'awesome job!', quantity: 1 } }
      it 'creates kudos_transaction and returns remaining quantity for the user' do
        post :create, format: :json, params: params
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['quantity']).to eq @user1.kudos_quantity.quantity
      end
    end

    context 'successful post' do
      let(:params) { { receiverId: @user2.id, message: 'awesome job!', quantity: 9 } }
      it 'creates kudos_transaction and returns remaining quantity for the user' do
        post :create, format: :json, params: params
        expect(response.status).to eq 422
        expect(JSON.parse(response.body).include?('Giver does not have enough kudos to give away.')).to be_truthy
      end
    end
  end
end
