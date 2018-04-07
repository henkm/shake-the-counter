module ShakeTheCounter

  # This class handles the login logic.
  # Shake The Counter uses OAuth
  # 
  # A HTTP POST request must be done to https://apitest.shakethecounter.com/token 
  # (the authorization server) with the following information:
  # Header Content-Type must be set to application/form-url-encoded
  class Authentication

    # 
    # Renews the access token from the refresh token.
    # https://auth0.com/learn/refresh-tokens/
    # 
    # body: 
    # grant_type=refresh_token&client_id=clientid&client_secret=clientsecret&refresh_token=refreshToken
    # 
    # @return String access_token
    def self.renew_access_token(client_id: '', client_secret: '', refresh_token: '')
      body = {
        grant_type: "refresh_token",
        client_id: client_id,
        client_secret: client_secret,
        refresh_token: refresh_token
      }
      result = ShakeTheCounter::API.call(
        "#{ShakeTheCounter::API.endpoint}/token",
        http_method: :post,
        body: body,
        header: {content_type: "application/x-www-form-urlencoded"}
      )
    end



    # 
    # Gets the authentication_token and refresh_token
    # from a username and password.
    # 
    # body: 
    # grant_type=password&client_id=clientid&client_secret=clientsecret&username=username&password=password
    # 
    # @return OpenStruct containing authentication_token and refresh_token
    def self.get_access_token(client_id: '', client_secret: '', username: '', password: '')
      body = {
        grant_type: "password",
        client_id: client_id,
        client_secret: client_secret,
        username: username,
        password: password
      }
      header = { content_type: "application/x-www-form-urlencoded" }
      result = ShakeTheCounter::API.call(
        "#{ShakeTheCounter::API.endpoint}/token",
        http_method: :post,
        header: header,
        body: body
      )
    end

  end


end
