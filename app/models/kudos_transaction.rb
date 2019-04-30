# frozen_string_literal: true

# Transaction model
class KudosTransaction < ActiveRecord::Base
  belongs_to :giver, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :users

  before_create :assign_default_date
  validates :message, length: { maximum: 1000 }
  validate :giver_kudos_quantity
  validate :giver_and_receiver_in_same_organization

  private

  def assign_default_date
    self.date = Date.today if date.blank?
  end

  def giver_kudos_quantity
    errors.add(:base, 'Giver does not have enough kudos to give away.') if (giver.kudos_quantity.quantity - quantity).negative?
  end

  def giver_and_receiver_in_same_organization
    errors.add(:base, 'Invalid giver or receiver.') unless giver.organization == receiver.organization
  end
end
