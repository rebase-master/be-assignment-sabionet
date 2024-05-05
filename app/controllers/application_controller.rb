# frozen_string_literal: true

# Common controller which acts as a base class for other controllers
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def render_404(_message, errors) # rubocop:disable Naming/VariableNumber
    respond_to do |format|
      format.html { render template: 'errors/not_found', formats: :html, layout: 'application', status: :not_found }
      format.json { render json: { error: errors }, status: :not_found, content_type: 'application/json' }
      format.any { head :not_found }
    end
  end

  def render_522(_message, errors) # rubocop:disable Naming/VariableNumber
    respond_to do |format|
      format.html { render template: 'errors/not_found', formats: :html, layout: 'application', status: :not_found }
      format.json { render json: { error: errors }, status: :not_found, content_type: 'application/json' }
      format.any { head :not_found }
    end
  end

  def log_exception(exception)
    backtrace_cleaner = request.env['action_dispatch.backtrace_cleaner']
    application_trace = ActionDispatch::ExceptionWrapper.new(backtrace_cleaner, exception).application_trace
    application_trace.map! { |t| "  #{t}\n" }
    logger.error "\n#{exception.class.name} (#{exception.message}):\n#{application_trace.join}"
  end
end
