# frozen_string_literal: true

# app/services/split_expense_service.rb
class SplitExpenseService < ApplicationService
  attr_reader :expense, :share_attributes

  def initialize(expense, share_attrs)
    @expense = expense
    @share_attributes = share_attrs
  end

  def call
    return if @share_attributes.blank?

    individual_share = calculate_share
    @share_attributes.each do |share|
      @expense
        .expense_shares
        .create(user_id: share['user_id'].to_i, amount: individual_share)
    end
  end

  private

  def calculate_share
    total_users = @share_attributes.length + 1 # Including the user who paid
    @expense.amount / total_users
  end
end
