module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # Handle all exceptions
    rescue_from StandardError,                      with: :server_error!
    rescue_from JWT::VerificationError,             with: :jwt_verification_error!
    rescue_from JWT::DecodeError,                   with: :jwt_decode_error!
    rescue_from JWT::ExpiredSignature,              with: :jwt_expired_signature!
    rescue_from I18n::InvalidLocale,                with: :i18n_invalid_locale!
    rescue_from Consul::Powerless,                  with: :consul_powerless!
    rescue_from CustomException::AuthUserNotFound,  with: :auth_user_not_found!
    rescue_from ActiveRecord::RecordNotFound,       with: :record_not_found!
    rescue_from CustomException::ExternalEmployeeExist, with: :external_employee_exist!
    rescue_from CustomException::AuthServiceError,  with: :auth_service_error!
  end

  # The message of record not found, can be customized by override it to the controllers
  def record_not_found_message
    resource_name&.present? ? I18n.t(:x_not_found, name: resource_name&.singularize&.titleize) : I18n.t(:not_found)
  end

  protected

  # Handle JWT::ExpiredSignature
  def jwt_expired_signature!
    render_unauthorized(error: 1201)
  end

  # Handle JWT::VerificationError
  def jwt_verification_error!
    render_unauthorized(error: 1202)
  end

  # Handle JWT::DecodeError
  def jwt_decode_error!
    render_unauthorized(error: 1203)
  end

  # Handle CustomException::InvalidToken
  def auth_user_not_found!
    render_unauthorized(error: 1206)
  end

  # Handle I18n::InvalidLocale
  def i18n_invalid_locale!
    render_unauthorized(error: 1004, params: params[:locale])
  end

  # Handle Consul::Powerless
  def consul_powerless!
    render_forbidden
  end

  # Handle ActiveRecord::RecordNotFound
  def record_not_found!
    render_not_found(message: record_not_found_message)
  end

  # Handle CustomException::ExternalEmployeeExist
  def external_employee_exist!
    render_unauthorized(error: 1309)
  end

  # Handle CustomException::AuthServiceError
  def auth_service_error!
    render_unauthorized(error: 1312)
  end

  # Handle StandardError
  def server_error!(e)
    Rails.logger.error(e.message)
    e.backtrace.each do |line|
      Rails.logger.error(line)
    end
    render_smart_error(1000)
  end
end
