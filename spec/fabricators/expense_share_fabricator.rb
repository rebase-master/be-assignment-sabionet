# frozen_string_literal: true

Fabricator(:expense_share) do
  user
  expense
  amount     '9.99'
  settled    false
  created_at '2024-04-29 10:26:27'
  updated_at '2024-04-29 10:26:27'
end
