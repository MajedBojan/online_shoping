# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  sub_category_id :integer          not null
#  user_id         :integer          not null
#  name            :string
#  description     :string
#  band_colour     :string
#  band_material   :string
#  brand           :string
#  dial_colour     :string
#  display_type    :string
#  price           :decimal(, )      default(0.0), not null
#  discount_price  :decimal(, )      default(0.0), not null
#  status          :integer          default(1), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :product do
    sub_category_id  { SubCategory.order('RANDOM()').first&.id }
    user_id          { User.order('RANDOM()').first&.id }
    name             { Faker::Commerce.product_name }
    description      { Faker::Company.catch_phrase }
    band_colour      { Faker::Commerce.color }
    dial_colour      { Faker::Color.hex_color}
    band_material    { Faker::Commerce.material}
    display_type     { Faker::Ancient.titan }
    brand            { Faker::Company.name }
    price            { Faker::Commerce.price }
    discount_price   { Faker::Commerce.price }
  end
end
