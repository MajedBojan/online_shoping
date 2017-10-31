class V1::CategoriesController < V1::BaseController
  skip_before_action :authenticate_request!, only: :index

  power :categories, map: {
    [:index]   => :category_index,
    [:show]    => :category_show,
    [:create]  => :creatable_category,
    [:update]  => :updatable_category,
    [:destroy] => :destroyable_employee
  }, as: :categories_scope

  private

  def category_params
    params.permit(:name, :status, :category_constant, :category_type)
  end
end
