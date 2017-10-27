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

class User < ApplicationRecord
  has_secure_password(validations: false)
  include UserPresenter

  # User Roles
  enum role: {
    customer: 1,
    admin:  2
  }

  # User Statuses
  enum status: {
    active:   1,
    inactive: 2
  }

  ## ----------------------- Enums ------------------------ ##

  # ِlogin method
  def self.login(email, password)
    active.find_by(email: email)&.authenticate(password) || false
  end

  ## ---------------------- Methods ----------------------- ##

  # JWT payload
  def login_payload
    {
      id:         self.id,
      full_name: self.full_name,
      username:  self.username,
      role:       self.role,
    }
  end

end
