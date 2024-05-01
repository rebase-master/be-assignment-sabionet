# frozen_string_literal: true

# spec/models/expense_spec.rb
require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe 'associations' do
    it { should belong_to(:paid_by).class_name('User') }
    it { should have_many(:expense_shares) }
    it { should have_many(:taxes) }
  end

  describe 'custom methods' do
    let(:user) { Fabricate(:user) }

    describe '#split_amount' do
      it 'calculates the split amount for an expense' do
        user2 = Fabricate(:user)
        expense = Fabricate(:expense, amount: 100, paid_by: user)
        Fabricate(:expense_share, user: user, expense: expense, amount: 50)
        Fabricate(:expense_share, user: user2, expense: expense, amount: 50)

        expect(expense.split_amount).to eq(0)
      end
    end
    describe '#calculate_tax' do
      it 'calculates the total tax amount correctly' do
        expense = Fabricate(:expense, amount: 100, paid_by: user)
        expense.taxes.build(amount: 10)
        expense.taxes.build(amount: 5)

        tax_amount = expense.calculate_tax

        expect(tax_amount).to eq(15)
      end
    end

    describe '#create_taxes' do
      it 'creates tax records for the expense' do
        expense = Fabricate(:expense, amount: 100, paid_by: user)
        tax_attributes = [{ 'name' => 'GST', 'amount' => 10 }, { 'name' => 'VAT', 'amount' => 5 }]

        expense.create_taxes(tax_attributes)

        expect(expense.taxes.count).to eq(2)
        expect(expense.taxes.map(&:name)).to contain_exactly('GST', 'VAT')
        expect(expense.taxes.map(&:amount)).to contain_exactly(10, 5)
      end
    end

    describe '.create_expense' do
      it 'creates a new expense record' do
        expense = Expense.create_expense(100, 'Test Expense', user)

        expect(expense.amount).to eq(100)
        expect(expense.description).to eq('Test Expense')
        expect(expense.paid_by).to eq(user)
      end
    end
  end
end
