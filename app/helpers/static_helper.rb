# frozen_string_literal: true

# Static helper
module StaticHelper
  def my_friends(user_id)
    User.friends(user_id)
  end
end
