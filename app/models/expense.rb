# frozen_string_literal: true

# Expense model
class Expense < ApplicationRecord
  belongs_to :paid_by, class_name: 'User'
  has_many :expense_shares, dependent: :destroy
  has_many :taxes, dependent: :destroy

  accepts_nested_attributes_for :taxes

  validates :description,
            presence: true
  validates :amount,
            presence: true,
            numericality: { greater_than: 0 }

  validates_associated :expense_shares

  def split_amount
    total_shares = expense_shares.sum(:amount)
    (amount - total_shares) / (expense_shares.size + 1)
  end

  def calculate_tax
    taxes.sum(&:amount)
  end

  def create_taxes(tax_attributes)
    tax_attributes.each_value do |tax|
      taxes.create!(name: tax['name'], amount: tax['amount'].to_f)
    end
  end

  def self.create_expense(amount, description, user)
    create!(
      amount: amount,
      description: description,
      paid_by: user
    )
  end
end
