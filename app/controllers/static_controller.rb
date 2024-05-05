# frozen_string_literal: true

# Handles the dashboard
class StaticController < ApplicationController
  def dashboard
    @dashboard = Dashboard.new(current_user)
    @expense = Expense.new
  end

  def person; end
end
