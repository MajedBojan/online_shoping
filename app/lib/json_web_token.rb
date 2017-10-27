class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base
  ALGORITHM   = 'HS256'.freeze


  # Encode and generate a token
  def self.encode(payload, exp = 24.hours.from_now)
    # set expiry to 24 hours from creation time
    payload[:iat] = Time.zone.now.to_i
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET, ALGORITHM)
  end

  # Decode and validate the token
  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new(body, true, algorithm: ALGORITHM[0])
  end
end
