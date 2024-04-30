# frozen_string_literal: true

# app/services/application_service.rb
class ApplicationService
  def self.call(...)
    new(...).call
  end

  def call(*args, &)
    raise NotImplementedError, 'Subclasses must implement a `call` method.'
  end
end
