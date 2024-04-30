# frozen_string_literal: true

# ExpenseShare model
class ExpenseShare < ApplicationRecord
  belongs_to :user
  belongs_to :expense

  validates :amount,
            presence: true,
            on: :update
end