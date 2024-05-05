# frozen_string_literal: true

# Dashboard
class Dashboard
  attr_accessor :user, :current_user

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def you_owe
    @user.amount_owed_by_you
  end

  def you_are_owed
    @user.amount_owed_to_you
  end

  def total_balance
    you_are_owed - you_owe
  end

  def debtors
    @user.debtors
  end

  def creditors
    @user.creditors
  end

  def all_users
    User.select(:id, :name)
  end

  def user_expenses
    @user.fetch_expenses(@user.id, @current_user.id)
  end
end
