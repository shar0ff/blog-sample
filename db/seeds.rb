# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin_user = User.where(email: "sharovivan17@gmail.com").first_or_initialize
admin_user.update!(
  password: "password",
  password_confirmation: "password",
  admin: true
)

regular_user = User.where(email: "sharoiva@cvut.cz").first_or_initialize
regular_user.update!(
  password: "password",
  password_confirmation: "password",
  admin: false
)
