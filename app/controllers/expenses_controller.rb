# frozen_string_literal: true

# app/controllers/expenses_controller.rb
class ExpensesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def create
    ExpenseManager.call(expense_params)
    render json: { status: 'Expense successfully added.' }, status: :ok
  end

  private

  def parameter_missing(exception)
    log_exception(exception)
    render json: { error: 'Parameter missing' }, status: :unprocessable_entity
  end

  def record_not_found(exception)
    log_exception(exception)
    render_404('Record not found!')
  end

  def expense_params
    params.require(:expense_attributes).permit(:paid_by, :amount, :description,
                                               shares_attributes: [:user_id],
                                               tax_attributes: %i[name amount])
  end
end
