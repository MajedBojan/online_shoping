class Errors::ErrorResponse
  attr_reader :message, :error_code, :error_url

  def initialize(error, options = {})
    @error   = error
    @options = options || {}
    set_error_code
    set_error_url
    set_message
    set_option
  end

  def self.parse(error, message = nil)
    if error.is_a?(Integer)
      ::Errors::CustomeError.new(error, message)
    elsif error.is_a?(Exception)
      ::Errors::ExceptionError.new(error, message)
    elsif error.is_a?(ApplicationRecord)
      ::Errors::ModelError.new(error, message)
    else
      ::Errors::CustomeError.new(1000, message || 'Undefined Error')
    end
  end

  def set_error_url
    @error_url = "/#{@error_code || 1000}"
  end

  def to_h
    {
      message:    @message,
      error_code: @error_code,
      error_url:  @error_url
    }
  end

  def set_option
    @message = @options[:message] if @options[:message].present?

    extra_message = @options[:params].is_a?(Array) ? @options[:params].map(&:to_s).join(', ') : @options[:params].to_s

    @message = @message + ': ' + extra_message if @options[:params].present?
  end

  alias to_json to_h
end
