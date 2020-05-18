RSpec.describe ShakeTheCounter::API do
  

  describe ".ping" do

    it 'has an endpoint' do
      expect(ShakeTheCounter::API.endpoint).to eq "https://apitest.ticketcounter.nl/swagger"
    end

    xit "returns 'ok'" do
      expect(ShakeTheCounter::API.ping).to eq 'ok'
    end
  end

end
