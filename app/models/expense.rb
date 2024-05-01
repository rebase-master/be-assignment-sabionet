# frozen_string_literal: true

# Expense model
class Expense < ApplicationRecord
  belongs_to :paid_by, class_name: 'User'
  has_many :expense_shares, dependent: :destroy
  has_many :taxes, dependent: :destroy

  validates :description,
            presence: true
  validates :amount,
            presence: true,
            numericality: { greater_than: 0 }

  accepts_nested_attributes_for :taxes

  def split_amount
    total_shares = expense_shares.sum(:amount)
    (amount - total_shares) / (expense_shares.size + 1)
  end

  def calculate_tax
    taxes.sum(&:amount)
  end

  def create_taxes(tax_attributes)
    tax_attributes.each do |tax|
      taxes.create(name: tax['name'], amount: tax['amount'])
    end
  end

  def self.create_expense(amount, description, user)
    create(
      amount: amount,
      description: description,
      paid_by: user
    )
  end
end
