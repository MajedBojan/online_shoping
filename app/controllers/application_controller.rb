class ApplicationController < ActionController::API
  include Responders
  include MissingData
  include ExceptionHandler
  include ActionController::Helpers

  private

  attr_reader :current_user
end
