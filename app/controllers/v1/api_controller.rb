class V1::ApiController < ApplicationController
  include Consul::Controller

  before_action :set_locale
  before_action :set_pagination, only: [:index]
  before_action :authenticate_request!

  require_power_check

  # Authenticate the request
  def authenticate_request!
    return if missing_headers!(['Authorization'])
    @token ||= AuthenticateRequest.get(User, request.headers)
    @current_user = @token[:user]
    @access       = @token[:access]
    return render_forbidden(error: 1305) if @current_user.inactive? # reject inactive/disabled users
  end

  private

  # Set Power and inject it with current user
  current_power do
    Power.new(current_user, @access)
  end
  
  # Set request locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Set Pagination, by definging
  def set_pagination
    @page  = (params[:page] || 1).to_i
    @limit = params[:limit].to_s == '-1' ? 999_999 : (params[:limit] || 10).to_i
    render_smart_error(1003) && return if @page < 1 || @limit < 1
  end
end
