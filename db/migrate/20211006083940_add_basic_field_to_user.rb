# frozen_string_literal: true

class AddBasicFieldToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :name
      t.string :mobile_number
    end
  end
end
