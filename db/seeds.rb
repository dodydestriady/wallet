# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
User.destroy_all
Stock.destroy_all
Team.destroy_all
Transaction.destroy_all
Wallet.destroy_all

# Create Users
system = User.create!(name: 'system', email: 'system', password: 'password123', password_confirmation: 'password123')
user = User.create!(name: 'John', email: 'john@mail.com', password: 'password123', password_confirmation: 'password123')
stock = Stock.create!(name: 'JohnDoe', email: 'johndoe#mail.com', password: 'password123', password_confirmation: 'password123')
team = Team.create!(name: 'Doe', email: 'doe#mail.com', password: 'password123', password_confirmation: 'password123')

# Create Wallets for Users
Wallet.create!(walletable: system)
Wallet.create!(walletable: user)
Wallet.create!(walletable: stock)
Wallet.create!(walletable: team)

# Initialize system wallet balance
Transaction.create!(amount: 9999999, target_wallet: system.wallet)

puts "Seeded #{User.count} users, #{Team.count} teams, #{Stock.count} stock and #{Wallet.count} wallets."