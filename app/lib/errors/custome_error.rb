class Errors::CustomeError < Errors::ErrorResponse
  def set_error_code
    @error_code = @error
  end

  def set_message
    @message = I18n.t("errors.#{@error_code}")
  end
end
