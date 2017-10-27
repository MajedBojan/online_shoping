class Errors::ModelError < Errors::ErrorResponse
  def set_error_code
    @error_code = 1010
  end

  def set_message
    @message = @error.errors.full_messages.to_sentence
  end
end
