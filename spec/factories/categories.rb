# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  status            :integer          default("active"), not null
#  category_constant :string
#  category_type     :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryBot.define do
  factory :category do
    name               { Faker::Name.title}
    category_constant  { SecureRandom.hex(2).upcase }
    category_type      { Faker::Number.number(1) }
  end
end
