# frozen_string_literal: true

# Tax model
class Tax < ApplicationRecord
  belongs_to :expense
end
