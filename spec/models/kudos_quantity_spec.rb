# frozen_string_literal: true

# KudosQuantity model spec
require 'rails_helper'

RSpec.describe KudosQuantity, type: :model do
  before :each do
    @user = create(:user)
    @kudos_quantity = @user.kudos_quantity
  end

  describe '#verify_quantity' do
    it 'returns error if user save negative quantity' do
      @kudos_quantity.quantity = -1;
      @kudos_quantity.save
      expect(@kudos_quantity.errors.full_messages.include?('Quantity Invalid quantity.')).to be_truthy
    end
  end

  describe '#withdraw' do
    it 'throws exception if user tries to withdraw quantity more than its balance' do
      expect { @kudos_quantity.withdraw(9) }.to raise_error
    end
  end
end
