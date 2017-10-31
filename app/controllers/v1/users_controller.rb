class V1::UsersController < V1::BaseController
  skip_before_action :authenticate_request!, only: :create

  power :users, map: {
    [:index]   => :user_index,
    [:show]    => :user_show,
    [:create]  => :creatable_user,
    [:update]  => :updatable_user,
    [:destroy] => :destroyable_employee
  }, as: :users_scope

  private

  def user_params
    params.permit(:full_name, :username, :email, :date_of_birth, :password)
  end
end
