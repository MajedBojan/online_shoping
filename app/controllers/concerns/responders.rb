module Responders
  # Render Data
  # always will have data to be rendered
  #
  # @param  [Hash]   data        The object will be rendered in data
  # @param  [Hash]   params = {} Allow :message to have a custom message
  #                                    :meta    to merge an extra hash to data
  # @return [render] render a json with status ok:200
  def render_data(data, params = {})
    message = params[:message] || message = I18n.t(:data_found)
    data    = params[:meta].present? ? data.merge(params[:meta]) : data
    render json: { success: true, message: message, data: data }, status: :ok
  end

  # Render a message
  # where message is required, and data is optional
  #
  # @param  [String] message     The action message
  # @param  [Hash]   params = {} Allow :data to have a custom object in data
  #                                    :meta to merge an extra hash to data if exist
  # @return [render] render a json with status ok:200
  def render_success(message, params = {})
    data = params[:data] || {}
    data = params[:meta].present? ? (data ? data.merge(params[:meta]) : params[:meta]) : data
    render json: { success: true, message: message, data: data }, status: :ok
  end

  # Render Created
  # where return the created object with default create message and status 201
  #
  # @param  [Hash]   data        The object will be rendered in data
  # @param  [Hash]   params = {} Allow :message to add custom message
  #                                    :meta    to merge an extra hash to data
  # @return [render] render a json with status created:201
  def render_created(data, params = {})
    message = params[:message] || message = I18n.t(:created_successfully)
    data    = params[:meta].present? ? data.merge(params[:meta]) : data
    render json: { success: true, message: message, data: data }, status: :created
  end

  ## Error Responders

  # def render_bad_request(options = {})
  #   render_error(message: message, error_code: error_code)
  # end
  def render_bad_request(options = {})
    render_smart_error((options[:error] || 1000), options)
  end

  def render_unprocessable_entity(options = {})
    render_smart_error((options[:error] || 1103), { status: :unprocessable_entity }.merge(options))
  end

  def render_unauthorized(options = {})
    render_smart_error((options[:error] || 1101), { status: :unauthorized }.merge(options))
  end

  def render_forbidden(options = {})
    render_smart_error((options[:error] || 1102), { status: :forbidden }.merge(options))
  end

  def render_not_found(options = {})
    render_smart_error((options[:error] || 1102), { status: :not_found }.merge(options))
  end

  def render_smart_error(error, options = {})
    response = Errors::ErrorResponse.parse(error, options)

    render_error(
      error_code: response.error_code,
      message:    response.message,
      status:     (options[:status] || :bad_request)
    )
  end

  # Global Error Renderer
  #
  # @param [Hash] params = {}   Accept  :error_code the error code, default 1010
  #                                     :message    the error message, default is bad request
  #                                     :status     the response status, default is bad_request:400
  # @return [render] render a json with status bad_request:400 as default
  def render_error(params = {})
    error_code = params[:error_code] || 1010
    message    = params[:message]    || I18n.t(:bad_request)
    status     = params[:status]     || :bad_request

    # will print the error in the console with colour
    Rails.logger.debug("  \e[41;1mError Response:\e[0m\e[41m #{error_code} | #{message}\e[0m")

    render json: {
      success:    false,
      message:    message,
      error_code: error_code
    }, status: status
  end
end
