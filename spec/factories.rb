FactoryBot.define do
  factory :user do
    first_name  { 'amy' }
    last_name  { 'lastname' }
    email { "#{first_name}_#{last_name}_#{Random.rand(1000).to_s}@factory.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
