# frozen_string_literal: true

# spec/models/expense_share_spec.rb
require 'rails_helper'

RSpec.describe ExpenseShare, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:expense) }
  end

  describe 'database columns' do
    it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:expense_id).of_type(:integer).with_options(null: false) }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount).on(:update) }
  end

  describe 'factory' do
    it 'is valid' do
      user = Fabricate(:user)
      expense = Fabricate(:expense, paid_by: user)
      expense_share = Fabricate(:expense_share, user: user, expense: expense, amount: 50)
      expect(expense_share).to be_valid
    end
  end
end
