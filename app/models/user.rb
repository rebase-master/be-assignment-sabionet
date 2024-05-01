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
end
