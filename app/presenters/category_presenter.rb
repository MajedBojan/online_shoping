module CategoryPresenter
  extend ActiveSupport::Concern

  included do
    acts_as_api

    ## ------------------ APIs Accessible ------------------- ##

    api_accessible :base do |t|
      t.add :id
      t.add :name
    end

    ## ----------------------- Users ------------------------ ##

    api_accessible :v1_index, extend: :base

    api_accessible :v1_show, extend: :v1_index

    ## ----------------------- Admin ------------------------ ##

    api_accessible :v1_admin_index, extend: :base

    api_accessible :v1_admin_show, extend: :v1_admin_index do |t|
      t.add :status
      t.add :category_constant
    end
  end
end
