# frozen_string_literal: true

# app/services/expense_manager.rb
class ExpenseManager < ApplicationService
  attr_reader :params, :share_attributes, :taxes_attributes

  def initialize(params)
    @params = params
    @shares_attributes = params.fetch(:expense_share_ids, nil)
    @taxes_attributes = params.fetch(:taxes_attributes, nil)
  end

  def call
    ActiveRecord::Base.transaction do
      expense = AddExpenseService.call(@params)
      TaxService.call(expense, @taxes_attributes) if @taxes_attributes
      SplitExpenseService.call(expense, @shares_attributes)
    end
  end
end
