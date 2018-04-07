RSpec.describe ShakeTheCounter::API do
  

  describe ".ping" do
    it "returns 'ok'" do
      expect(ShakeTheCounter::API.ping).to eq 'ok'
    end
  end

end
