# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :description
      t.decimal :amount, precision: 10, scale: 2
      t.references :paid_by, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
