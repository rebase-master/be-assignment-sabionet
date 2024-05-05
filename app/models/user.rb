# frozen_string_literal: true

# User model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses, foreign_key: :paid_by_id, inverse_of: :paid_by, dependent: :destroy
  has_many :expense_shares, dependent: :destroy

  def self.friends(user_id)
    where(id: ExpenseShare.select(:user_id)
                           .joins(:expense)
                           .where(expenses: { paid_by_id: user_id })
                           .distinct)
      .where.not(id: user_id)
  end

  def debtors
    User.joins(expense_shares: :expense).where(expenses: { paid_by_id: id })
        .group('users.id')
        .select('users.name, users.id, SUM(expense_shares.amount) AS total_amount')
        .having('SUM(expense_shares.amount) > 0')
  end

  def creditors
    ExpenseShare.joins(expense: :paid_by)
                .where(user_id: id)
                .group('users.id, users.name')
                .select('users.id, users.name, SUM(expense_shares.amount) AS total_amount')
  end

  def fetch_expenses(user_id, current_user_id)
    Expense.select('expenses.id, expenses.description, expenses.amount, expenses.paid_by_id, expense_shares.user_id,
                   expense_shares.amount AS share, expenses.created_at')
           .joins(:expense_shares)
           .where('((expenses.paid_by_id = ? AND expense_shares.user_id = ?) OR
                  (expenses.paid_by_id = ? AND expense_shares.user_id = ?))
                  AND expense_shares.amount IS NOT NULL', user_id, current_user_id, current_user_id, user_id)
           .group('expenses.id, expense_shares.user_id, expenses.description, expenses.amount, expense_shares.amount')
  end

  def amount_owed_by_you
    expense_shares.sum(:amount).round(2, :up)
  end

  def amount_owed_to_you
    total_shared = ExpenseShare.joins(:expense).where(expenses: { paid_by_id: id }).sum(:amount)
    total_shared.to_f.round(2)
  end
end
