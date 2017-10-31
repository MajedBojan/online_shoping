# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  full_name       :string           not null
#  username        :string           not null
#  password_digest :string           not null
#  email           :string           not null
#  status          :integer          default("active"), not null
#  role            :integer          default("customer"), not null
#  date_of_birth   :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :user do
    full_name       { Faker::GameOfThrones.character }
    username        { Faker::Name.last_name }
    email           { Faker::Internet.email(full_name) }
    password_digest { Faker::Number.number(5) }

  end
end
