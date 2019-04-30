# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def seed_organizations
  Organization.create(name: 'ABC Company')
  Organization.create(name: 'DEF Company')
end

def seed_users
  users = [
    {
      first_name: 'Brian', last_name: 'Martin', password: 'password', password_confirmation: 'password', email: 'a@mail.com'
    },
    {
      first_name: 'Daniel', last_name: 'Smith', password: 'password', password_confirmation: 'password', email: 'b@mail.com'
    },
    {
      first_name: 'Tim', last_name: 'Hong', password: 'password', password_confirmation: 'password', email: 'c@mail.com'
    },
    {
      first_name: 'Alice', last_name: 'Sip', password: 'password', password_confirmation: 'password', email: 'd@mail.com'
    },
    {
      first_name: 'Mike', last_name: 'Goodwill', password: 'password', password_confirmation: 'password', email: 'e@mail.com'
    },
    {
      first_name: 'Will', last_name: 'Roy', password: 'password', password_confirmation: 'password', email: 'f@mail.com'
    }
  ]
  users.each do |user|
    User.create(
      first_name: user[:first_name],
      last_name: user[:last_name],
      password: user[:password],
      password_confirmation: user[:password_confirmation],
      email: user[:email]
    )
  end
end

def seed_kudos_transactions
  transaction = KudosTransaction.new(giver: User.all[0], receiver: User.all[3], quantity: 2, message: 'Job well done on last deployment.')
  process_kudos_transaction(transaction)
  transaction = KudosTransaction.new(giver: User.all[1], receiver: User.all[0], date: Date.today - 3, quantity: 1, message: 'Thanks for helping test at last minute.')
  process_kudos_transaction(transaction)
  transaction = KudosTransaction.new(giver: User.all[3], receiver: User.all[1], quantity: 1, message: 'Awsome job on refactoring.')
  process_kudos_transaction(transaction)
end

def process_kudos_transaction(transaction)
  ActiveRecord::Base.transaction do
    transaction.save
    transaction.giver.kudos_quantity.withdraw(transaction.quantity)
    raise ActiveRecord::Rollback if transaction.errors.any?
  end
end

seed_organizations
seed_users
seed_kudos_transactions
