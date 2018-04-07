RSpec.describe ShakeTheCounter::Authentication do
  
  xdescribe ".get_access_token" do
    before(:all) do
      @result = ShakeTheCounter::Authentication.get_access_token(username: ENV['STC_USERNAME'], password: ENV['STC_PASSWORD'])
    end

    it "returns access_token and refresh_token " do
      expect(@result).to be_an OpenStruct
    end

    it "returns access_token and refresh_token " do
      expect(@result).to be_a Hash
    end
  end


  describe ".renew_access_token" do
    before(:all) do
      @result = ShakeTheCounter::Authentication.renew_access_token(client_id: CLIENT_ID, client_secret: CLIENT_SECRET, refresh_token: REFRESH_TOKEN)
    end

    it "returns a hash" do
      expect(@result).to be_an OpenStruct
    end

    it "returns an access token" do
      expect(@result.access_token).to be_a String
      expect(@result.access_token.length).to be > 50
    end
  end

end
