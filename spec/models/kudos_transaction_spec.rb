# frozen_string_literal: true

# KusoTransaction model spec
require 'rails_helper'

RSpec.describe KudosTransaction, type: :model do
  before :each do
    @user1 = create(:user, first_name: 'Alex')
    @user2 = create(:user, first_name: 'Brain')
    @user3 = create(:user, first_name: 'Will')
  end

  describe '#giver_kudos_quantity' do
    it 'returns error if user give more kudos then its blance' do
      transaction = KudosTransaction.create(giver: @user1, receiver: @user2, quantity: 5)
      expect(transaction.errors.full_messages.include?('Giver does not have enough kudos to give away.')).to be_truthy
    end
  end

  describe '#assign_default_date' do
    it 'assigns default date to a transaction' do
      transaction = KudosTransaction.create(giver: @user1, receiver: @user2, quantity: 1)
      expect(transaction.date).to eq(Date.today)
    end
  end

  describe '#giver_and_receiver_in_same_organization' do
    it 'returns error if giver and receiver are not in the same organization' do
      transaction = KudosTransaction.create(giver: @user1, receiver: @user3, quantity: 1)
      expect(transaction.errors.full_messages.include?('Invalid giver or receiver.')).to be_truthy
    end
  end
end
