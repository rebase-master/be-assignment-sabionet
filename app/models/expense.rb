# frozen_string_literal: true

# Expense model
class Expense < ApplicationRecord
  belongs_to :paid_by, class_name: 'User'
  has_many :expense_shares, dependent: :destroy
  has_one :tax, dependent: :destroy
end
