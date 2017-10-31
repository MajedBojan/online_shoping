module ProductPresenter
  extend ActiveSupport::Concern

  included do
    acts_as_api

    ## ------------------ APIs Accessible ------------------- ##

    api_accessible :base do |t|
      t.add :id
      t.add :sub_category_id
      t.add :user_id
      t.add :name
      t.add :description
    end

    ## ----------------------- Users ------------------------ ##

    api_accessible :v1_index, extend: :base

    api_accessible :v1_show, extend: :v1_index do |t|
      t.add :band_colour
      t.add :band_material
      t.add :brand
      t.add :dial_colour
      t.add :display_type
      t.add :price
      t.add :discount_price
    end

    ## ----------------------- Admin ------------------------ ##

    api_accessible :v1_admin_index, extend: :base

    api_accessible :v1_admin_show, extend: :v1_admin_index do |t|
      t.add :band_colour
      t.add :band_material
      t.add :brand
      t.add :dial_colour
      t.add :display_type
      t.add :price
      t.add :discount_price
      t.add :status
    end
  end
end
