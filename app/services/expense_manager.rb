# frozen_string_literal: true

# app/services/expense_manager.rb
class ExpenseManager < ApplicationService
  attr_reader :params, :share_attributes, :tax_attributes

  def initialize(params)
    @params = params
    @shares_attributes = params.fetch(:shares_attributes, nil)
    @tax_attributes = params.fetch(:tax_attributes, nil)
  end

  def call
    expense = AddExpenseService.call(@params)
    SplitExpenseService.call(expense, @shares_attributes) if @shares_attributes
    TaxService.call(expense, @tax_attributes) if @tax_attributes
  end
end
