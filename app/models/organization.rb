# frozen_string_literal: true

# Organization model
class Organization < ActiveRecord::Base
  has_many :users
  validates :name, presence: true, length: { maximum: 100 }
end
