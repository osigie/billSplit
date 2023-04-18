# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create! email: 'john@educative.io', password: 'topsecret', password_confirmation: 'topsecret'
User.create! email: 'max@educative.io', password: 'topsecret', password_confirmation: 'topsecret'
User.create! email: 'della@educative.io', password: 'topsecret', password_confirmation: 'topsecret'
