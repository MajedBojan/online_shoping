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

class Product < ApplicationRecord

  ## -------------------- Requirements -------------------- ##
  include ProductPresenter

  ## ---------------------- Associations ------------------ ##
  belongs_to :sub_category
  belongs_to :user

  ## --------------------- Callbacks ---------------------- ##
  ## -------------------- Validations --------------------- ##
  ## ----------------------- Enums ------------------------ ##
  ## ------------------- Class Methods -------------------- ##
  ## ---------------------- Methods ----------------------- ##

end
