class V1::SubCategoriesController < V1::BaseController
  skip_before_action :authenticate_request!, only: :index
  power :sub_categories, map: {
    [:index]   => :sub_category_index,
    [:show]    => :sub_category_show,
    [:create]  => :creatable_sub_category,
    [:update]  => :updatable_sub_category,
    [:destroy] => :destroyable_sub_employee
  }, as: :sub_categories_scope

  private

  def sub_category_params
    params.permit(:name, :status, :category_id)
  end
end
