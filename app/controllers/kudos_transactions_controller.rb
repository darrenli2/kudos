# frozen_string_literal: true

# KudosTransactions controller
class KudosTransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.same_organization(current_user) # TODO: add pagination
    @kudos_received = KudosTransaction.where(receiver: current_user) # TODO: add pagination
    @kudos_given = KudosTransaction.where(giver: current_user) # TODO: add pagination
  end

  def create
    transaction = build_transaction
    result = false
    ActiveRecord::Base.transaction do
      begin
        result = transaction.save
        transaction.giver.kudos_quantity.withdraw(transaction.quantity) if result
      rescue StandardError => e
        raise ActiveRecord::Rollback
      end
    end
    if result
      render json: { quantity: current_user.kudos_quantity.quantity}
    elsif transaction.errors.blank?
      render json: 'Giver does not have enough kudos to give away', status: :unprocessable_entity
    else
      render json: transaction.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def build_transaction
    KudosTransaction.new(
      receiver_id: params[:receiverId],
      giver: current_user,
      message: params[:message],
      quantity: params[:quantity]
    )
  end
end
