# frozen_string_literal: true

# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(128) }
  end

  describe 'associations' do
    it { should have_many(:expenses).with_foreign_key(:paid_by_id).inverse_of(:paid_by).dependent(:destroy) }
    it { should have_many(:expense_shares).dependent(:destroy) }
  end

  describe 'database columns' do
    it { should have_db_column(:email).of_type(:string).with_options(null: false) }
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
  end

  describe 'factory validation' do
    it 'is valid' do
      user = Fabricate(:user)
      expect(user).to be_valid
    end
  end

  describe '#friends' do
    it 'returns the list of friends' do
      user = Fabricate(:user)
      friend = Fabricate(:user)
      expense = Fabricate(:expense, paid_by: user)
      Fabricate(:expense_share, user: friend, expense: expense)

      expect(User.friends(user.id)).to include(friend)
    end
  end

  describe '#debtors' do
    it 'returns the list of users who owe money' do
      user = Fabricate(:user)
      debtor = Fabricate(:user)
      expense = Fabricate(:expense, paid_by: user)
      Fabricate(:expense_share, user: debtor, expense: expense, amount: 10.0)

      expect(user.debtors).to include(debtor)
    end
  end

  describe '#creditors' do
    it 'returns the list of users to whom money is owed' do
      user = Fabricate(:user)
      creditor = Fabricate(:user)
      expense = Fabricate(:expense, paid_by: creditor)
      Fabricate(:expense_share, user: user, expense: expense, amount: 10.0)

      expect(user.creditors.map(&:id)).to include(creditor.id)
    end
  end

  describe '#amount_owed_by_you' do
    it 'returns the total amount owed by the user' do
      user = Fabricate(:user)
      expense = Fabricate(:expense, paid_by: user)
      Fabricate(:expense_share, user: user, expense: expense, amount: 10.0)
      Fabricate(:expense_share, user: user, expense: expense, amount: 15.0)

      expect(user.amount_owed_by_you).to eq(25.0)
    end
  end

  describe '#amount_owed_to_you' do
    it 'returns the total amount owed to the user' do
      user = Fabricate(:user)
      expense = Fabricate(:expense, paid_by: user)
      Fabricate(:expense_share, user: user, expense: expense, amount: 10.0)
      Fabricate(:expense_share, user: user, expense: expense, amount: 15.0)

      expect(user.amount_owed_to_you).to eq(25.0)
    end
  end
end
