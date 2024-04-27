# frozen_string_literal: true

class CreateTaxes < ActiveRecord::Migration[6.1]
  def change
    create_table :taxes do |t|
      t.string :name
      t.decimal :amount, precision: 5, scale: 2
      t.references :expense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
