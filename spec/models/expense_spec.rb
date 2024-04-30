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
    it { should have_one(:tax) }
  end

  describe 'custom methods' do
    describe '#split_amount' do
      it 'calculates the split amount for an expense' do
        user1 = Fabricate(:user)
        user2 = Fabricate(:user)
        expense = Fabricate(:expense, amount: 100, paid_by: user1)
        Fabricate(:expense_share, user: user1, expense: expense, amount: 50)
        Fabricate(:expense_share, user: user2, expense: expense, amount: 50)

        expect(expense.split_amount).to eq(0)
      end
    end
  end
end
