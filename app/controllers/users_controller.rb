# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  def index
    users = User.pluck(:id, :name)
    respond_to do |format|
      format.json { render json: { users: users } }
    end
  end
end
