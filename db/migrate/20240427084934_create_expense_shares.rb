# frozen_string_literal: true

class CreateExpenseShares < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_shares do |t|
      t.references :user, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.boolean :settled, default: false, null: false

      t.timestamps
    end
  end
end
