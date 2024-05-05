# frozen_string_literal: true

# AddExpenseService
class AddExpenseService < ApplicationService
  attr_reader :amount, :description, :user

  def initialize(expense_params)
    @amount = expense_params.fetch(:amount, nil)
    @description = expense_params.fetch(:description, nil)
    @user = User.find(expense_params.fetch(:paid_by_id, 0))
  end

  def call
    Expense.create_expense(@amount, @description, @user)
  end
end
