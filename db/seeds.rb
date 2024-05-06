# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Fabricate.times(10, :user) if Rails.env.development?

# Create sample users
User.create!(name: 'John Doe', email: 'john@example.com', password: 'DSW*34hbE$Rt')
User.create!(name: 'Jane Doe', email: 'jane@example.com', password: 'DSW*34hbE$Rt')
User.create!(name: 'Janet Doe', email: 'janet@example.com', password: 'DdW*34hbE$Rt')
User.create!(name: 'Jim Doe', email: 'jim@example.com', password: 'DSW*64hbE$Rt')
User.create!(name: 'Joel Doe', email: 'joel@example.com', password: 'DSw*34hbE$Rt')

# Create sample expenses
# expense1 = Expense.create(description: 'Dinner', amount: 100, paid_by: user1)
# expense2 = Expense.create(description: 'Lunch', amount: 50, paid_by: user2)
#
# # Create sample expense shares
# ExpenseShare.create(user: user1, expense: expense1, amount: 50)  # Assuming the dinner expense is shared equally
# ExpenseShare.create(user: user2, expense: expense1, amount: 50)
#
# ExpenseShare.create(user: user1, expense: expense2, amount: 30)  # Assuming the dinner expense is shared equally
# ExpenseShare.create(user: user2, expense: expense2, amount: 20)
#
# # Create sample tax
# Tax.create(name: 'GST', amount: 10, expense: expense1)
# Tax.create(name: 'GST', amount: 7, expense: expense2)
