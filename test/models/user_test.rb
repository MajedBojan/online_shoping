# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  full_name     :string           not null
#  username      :string
#  email         :string           not null
#  status        :integer          default("active"), not null
#  role          :integer          default("customer"), not null
#  date_of_birth :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
