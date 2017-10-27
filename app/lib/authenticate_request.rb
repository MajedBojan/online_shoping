class AuthenticateRequest
  attr_reader :headers

  def self.get(model, headers = {})
    new(model, headers).call
  end

  def initialize(model, headers = {})
    @headers = headers
    @model   = model
  end

  # Service entry point - return valid user object
  def call
    {
      user: user,
      access: decoded_auth_token[:access]
    }
  end

  private

  def user
    # check if user is in the database
    # memoize user object
    @user ||= @model.find(decoded_auth_token[:id]) if decoded_auth_token
    # handle user not found
  rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise(CustomException::AuthUserNotFound, 'Authorizated user not exist')
  end

  # decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(auth_token)
  end

  # check for auth_token in `Authorization` header
  def auth_token
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?

    raise(CustomException::MissingToken, 'token is missing')
  end
end
