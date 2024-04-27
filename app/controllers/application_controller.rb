# frozen_string_literal: true

# Common controller which acts as a base class for other controllers
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
end
