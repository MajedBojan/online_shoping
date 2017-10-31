# frozen_string_literal: true

class Power
  include Consul::Power

  def initialize(user, access = 'app')
    @current_user = user
    @access       = access
  end

  # check if the current users is an admin
  def admin?
    return true if @current_user&.admin? #&& @access == 'admin'
    false
  end

  def sub_admin?
    return true if @current_user&.customer?
    false
  end

  # Generate powers for all tables and by default prevent them all from access
  ActiveRecord::Base.connection.tables.map(&:to_sym) - %i[schema_migrations ar_internal_metadata].each do |model|
    power model do
      false
    end
  end

  # allow evryone to user sessions api
  power :sessions do
    true
  end

  ##------------------------------ UsersController -----------------------------------##
  power :user_index do
    return User.all if admin?
    User.none
  end

  power :user_show do
    User
  end

  power :creatable_user do
    true
  end

  power :updatable_user do
    User
  end

  power :destroyable_user do
    User
  end

  ##------------------------------ CategoryController -----------------------------------##

  power :category_index do
    Category
  end

  power :category_show do
    return Category if admin?
    Category.none
  end

  power :creatable_category do
    return true if admin?
    false
  end

  power :updatable_category do
    return Category if admin?
    false
  end

  power :destroyable_employee do
    return Category if admin?
    false
  end
  ##------------------------------ SubCategoriesController -----------------------------------##

  power :sub_category_index do
    SubCategory
  end

  power :sub_category_show do
    return SubCategory if admin?
    SubCategory.none
  end

  power :creatable_sub_category do
    return true if admin?
    false
  end

  power :updatable_sub_category do
    return SubCategory if admin?
    false
  end

  power :destroyable_sub_category do
    return SubCategory if admin?
    false
  end

  ##------------------------------ productsController -----------------------------------##

  power :product_index do |sub_category_id|
    SubCategory.find(sub_category_id).products#.includes(:user)
  end

  power :product_show do |sub_category_id|
    SubCategory.find(sub_category_id).products
  end

  power :creatable_product do |sub_category_id|
    return true if admin?
    false
  end

  power :updatable_product do |sub_category_id|
    return SubCategory.find(sub_category_id).products if admin?
    false
  end

  power :destroyable_product do |sub_category_id|
    return SubCategory.find(sub_category_id).products if admin?
    false
  end
end
