# frozen_string_literal: true

# User model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true, length: { maximum: 50 }

  has_one :kudos_quantity, autosave: true, dependent: :destroy
  belongs_to :organization
  before_validation :assign_organization
  after_create_commit :create_kudos_quantity

  def self.same_organization(user)
    User.all.select{ |u| (u.organization == user.organization) }
  end

  def full_name
    first_name + ' ' + last_name
  end

  private

  def assign_organization
    return if organization
    # for now we just assign user to a organization by its first_name's first letter
    if %w(A B C D E F G H I G K).include?(first_name.first.upcase)
      self.organization = Organization.first
    else
      self.organization = Organization.second
    end
  end
end
