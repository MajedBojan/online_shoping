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

require 'test_helper'

class SubCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
