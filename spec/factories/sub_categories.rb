# == Schema Information
#
# Table name: sub_categories
#
#  id          :integer          not null, primary key
#  category_id :integer          not null
#  name        :string
#  status      :integer          default(1), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :sub_category do
    category_id  { Category.order('RANDOM()').first&.id }
    name         { Faker::Name.title}

  end
end
