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

class Category < ApplicationRecord
  ## -------------------- Requirements -------------------- ##
  include CategoryPresenter

  ## ---------------------- Associations ------------------ ##
  has_many :sub_categories, dependent: :destroy

  ## --------------------- Callbacks ---------------------- ##
  ## -------------------- Validations --------------------- ##
  ## ------------------- Class Methods -------------------- ##
  ## ---------------------- Methods ----------------------- ##


  ## ----------------------- Enums ------------------------ ##
  # Category Statuses
  enum status: {
    active:   1,
    inactive: 2
  }

end
## -------------------- Requirements -------------------- ##
## ---------------------- Associations ------------------ ##
## --------------------- Callbacks ---------------------- ##
## -------------------- Validations --------------------- ##
## ----------------------- Enums ------------------------ ##
## ------------------- Class Methods -------------------- ##
## ---------------------- Methods ----------------------- ##
