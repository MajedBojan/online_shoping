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

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
