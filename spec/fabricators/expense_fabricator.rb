# frozen_string_literal: true

Fabricator(:expense) do
  id          1
  description 'MyString'
  amount      '9.99'
  paid_by_id  1
  created_at  '2024-04-27 16:16:19'
  updated_at  '2024-04-27 16:16:19'
end
