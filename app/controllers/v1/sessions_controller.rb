class V1::SessionsController < V1::BaseController
  power :sessions
  skip_before_action :authenticate_request!

  def create
    return if missing_params!([:email, :password])
    @user = User.login(params[:email], params[:password])
    return render_bad_request(error: 1301) unless @user.present?
    return render_bad_request(error: @user)  if @user.errors.any?
    render_login
  end

  private

  # Success login response
  def render_login
    data = { user: @user.as_api_response(:v1_profile) }
    render_data(data, meta: generate_token(@user), message: I18n.t('sessions.login_successfully'))
  end

  # Session Meta Payload (token + role)
  def generate_token(user)
    payload = user.login_payload
    payload.merge!(access: params[:access] || 'app')
    {
      role: user.role,
      token: JsonWebToken.encode(payload, token_expire)
    }
  end

  # token expir timing
  def token_expire
    params[:access] == 'admin' ?  10.hours.from_now : 720.hours.from_now
  end
end
