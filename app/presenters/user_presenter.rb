module UserPresenter
  extend ActiveSupport::Concern

  included do
    acts_as_api

    ## ------------------ APIs Accessible ------------------- ##

    api_accessible :base do |t|
      t.add :id
      t.add :full_name
      t.add :username
      t.add :email
      t.add :role
    end

    ## ----------------------- Users ------------------------ ##

    api_accessible :v1_index, extend: :base

    api_accessible :v1_show, extend: :v1_index

    ## ----------------------- Admin ------------------------ ##

    api_accessible :v1_admin_index, extend: :base

    api_accessible :v1_admin_show, extend: :v1_admin_index

    ## ----------------------- Login ------------------------ ##
    api_accessible :v1_profile, extend: :base
  end
end
