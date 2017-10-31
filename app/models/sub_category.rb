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

class SubCategory < ApplicationRecord
  ## -------------------- Requirements -------------------- ##
  include SubCategorPresenter

  ## ---------------------- Associations ------------------ ##
  belongs_to :category
  has_many :products, dependent: :destroy

  ## --------------------- Callbacks ---------------------- ##
  ## -------------------- Validations --------------------- ##
  ## ----------------------- Enums ------------------------ ##
  ## ------------------- Class Methods -------------------- ##
  ## ---------------------- Methods ----------------------- ##

end
