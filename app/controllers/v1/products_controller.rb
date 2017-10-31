class V1::ProductsController < V1::BaseController
  skip_before_action :authenticate_request!, only: :index
  power :products, context: :sub_category_id, map: {
    [:index]   => :product_index,
    [:show]    => :product_show,
    [:create]  => :creatable_product,
    [:update]  => :updatable_product,
    [:destroy] => :destroyable_product
  }, as: :products_scope

  private

  def sub_category_id
    params[:sub_category_id] || ""
  end

  def product_params
    params.permit(:user_id, :name, :description, :band_colour, :band_material, :brand,
                  :dial_colour, :brand, :dial_colour, :display_type, :price, :discount_price, :status)
  end

  def params_processed
    return product_params.merge({ user_id: @current_user.id, sub_category_id: sub_category_id }).permit! unless @current_user.admin?
    product_params.merge({ sub_category_id: sub_category_id }).permit!
  end
end
