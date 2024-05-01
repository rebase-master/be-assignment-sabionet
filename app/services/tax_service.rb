# frozen_string_literal: true

# app/services/split_expense_service.rb
class TaxService < ApplicationService
  attr_reader :expense, :tax_attributes

  def initialize(expense, tax_attrs)
    @expense = expense
    @tax_attributes = tax_attrs
  end

  def call
    return if @tax_attributes.blank?

    @expense.create_taxes(@tax_attributes)
  end
end
