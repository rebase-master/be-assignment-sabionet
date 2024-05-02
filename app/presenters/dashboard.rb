# frozen_string_literal: true

# Dashboard
class Dashboard
  attr_accessor :user

  def initialize(user)
    @user = user
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
end
