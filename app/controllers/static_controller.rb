# frozen_string_literal: true

# Handles the dashboard
class StaticController < ApplicationController
  before_action :init_dashboard, only: %i[dashboard person]

  def dashboard; end

  def person
    redirect_to root_path if params[:id].to_i == current_user.id
  end

  private

  def init_dashboard
    user = params[:id] ? User.find(params[:id]) : current_user
    @dashboard = Dashboard.new(user, current_user)
    @expense = Expense.new
  end
end
