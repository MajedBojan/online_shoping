class Errors::ExceptionError < Errors::ErrorResponse
  def set_error_code
    @error_code = 1000 # Global Error
  end

  def set_message
    @message = @error.message
  end
end
