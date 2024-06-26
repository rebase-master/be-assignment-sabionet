# frozen_string_literal: true

# app/services/split_expense_service.rb
class SplitExpenseService < ApplicationService
  attr_reader :expense, :share_attributes

  def initialize(expense, share_attrs)
    @expense = expense
    @share_attributes = share_attrs
  end

  def call
    individual_share = calculate_share
    @share_attributes.each do |share_id|
      @expense
        .expense_shares
        .create!(user_id: share_id, amount: individual_share)
    end
  end

  private

  def calculate_share
    total_users = @share_attributes.length + 1 # Including the user who paid
    (@expense.amount + @expense.calculate_tax) / total_users
  end
end
