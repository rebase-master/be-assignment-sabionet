# frozen_string_literal: true

# Handles the dashboard
class StaticController < ApplicationController
  def dashboard
    @user = current_user
  end

  def person; end
end
