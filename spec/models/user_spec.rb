# frozen_string_literal: true

# User model spec
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#first_name' do
    before :each do
      @user = build(:user, first_name: '')
    end

    it 'returns error if firstname is blank' do
      @user.save
      expect(@user.errors.full_messages.include?("First name can't be blank")).to be_truthy
    end

    it 'creates a user if all required fields are filled' do
      @user.first_name = 'testname'
      expect(@user.save).to be_truthy
    end
  end

  describe '#last_name' do
    before :each do
      @user = build(:user, last_name: '')
    end

    it 'returns error if lastname is blank' do
      @user.save
      expect(@user.errors.full_messages.include?("Last name can't be blank")).to be_truthy
    end
  end

  describe '#assign_organization' do
    before :each do
      @user1 = build(:user, first_name: 'Abc')

      @user2 = build(:user, first_name: 'Ubc')
    end

    it 'assigns an orginazation by firstname if no orginization is assigned' do
      @user1.save
      expect(@user1.organization).to eq(Organization.first)
      @user2.save
      expect(@user2.organization).to eq(Organization.second)
    end
  end
end
