# frozen_string_literal: true

# ShareExpenseService
class ShareExpenseService
  def initialize(expense_id, shares_params)
    @expense = Expense.find(expense_id)
    @shares_params = shares_params
  end

  def call
    @shares_params.each do |share_params|
      @expense.expense_shares.create(share_params)
    end
  end
end
