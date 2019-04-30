# frozen_string_literal: true

# Kudos_quantity model
class KudosQuantity < ActiveRecord::Base
  belongs_to :user

  validate :verify_quantity

  def withdraw(number)
    self.quantity -= number
    save!
  end

  private

  def verify_quantity
    errors.add(:quantity, 'Invalid quantity.') if quantity.negative?
  end
end
