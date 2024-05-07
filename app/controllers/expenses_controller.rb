# frozen_string_literal: true

# app/controllers/expenses_controller.rb
class ExpensesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :show_errors

  def create
    raise ActionController::ParameterMissing, :expense_share_ids if expense_params.fetch(:expense_share_ids).empty?

    ExpenseManager.call(expense_params)
    render json: { status: 'Expense successfully added.' }, status: :ok
  end

  def settle
    current_user.settle_expenses(params[:user_id])
    render json: { status: 'Expense successfully settled.' }, status: :ok
  end

  private

  def parameter_missing(exception)
    log_exception(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def record_not_found(exception)
    log_exception(exception)
    render_404('Record not found!', exception.record.errors)
  end

  def show_errors(exception)
    log_exception(exception)
    render_522('Record Invalid!', exception.record.errors)
  end

  def expense_params
    params.require(:expense).permit(:paid_by_id, :amount, :description, :created_at,
                                    expense_share_ids: [],
                                    taxes_attributes: %i[name amount]).tap do |whitelisted|
      whitelisted[:expense_share_ids]&.reject!(&:blank?)
    end
  end
end
