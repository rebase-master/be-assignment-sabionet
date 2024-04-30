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
end
