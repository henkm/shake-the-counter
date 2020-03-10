RSpec.describe ShakeTheCounter::Client do
  
  describe ".initalize" do
    context "without arguments" do 
      it "returns has a client_id from config" do
        client = ShakeTheCounter::Client.new
        expect(client.id).not_to be_nil
      end
    end

    context "with arguments" do 
      it "returns has a client_id from argumens" do
        client = ShakeTheCounter::Client.new(id: 'test@example.org')
        expect(client.id).to eq 'test@example.org'
      end
    end
  end

  describe "#authentication_token" do
    let(:client) { ShakeTheCounter::Client.new }
    
    it "fetches a new authentication_token" do
      expect(client.access_token).to be_a String
    end

    it "doesnt fetch a new token a second time around, but serves from memory" do
      token_1 = client.access_token
      token_2 = client.access_token
      expect(token_1).to be token_2
    end
  end

  describe "#events", focus: true do
    

    before(:all) do 
      @client = ShakeTheCounter::Client.new
      @events = @client.events
    end

    it "makes a successful API call and returns an Array" do
      expect(@events).to be_an Array
    end

    it "makes a successful API call" do
      expect(@events.first).to be_an ShakeTheCounter::Event
    end

    it "has many performances" do
      expect(@events.first.performances.count).to be >= 1
    end

    it "has a client" do
      expect(@events.first.client).to be @client
    end

    describe "a single Performance" do
      describe "#sections" do

        before(:all) do
          @performance = @events.first.performances.first
          @sections = @performance.sections
        end

        it "returns an Array" do
          expect(@sections).to be_an Array
        end


        describe "#price_types" do
          before(:all) do
            @section = @sections.first
            @price_types = @section.price_types
          end

          it "has a ticket_valid_from attribute of type DateTime" do
            expect(@price_types.first.ticket_valid_from).to be_an DateTime
          end
        end

        describe "#make_reservation", focus: true do
          before(:all) do
            @section = @sections.first
            @price_types = @section.price_types
            price_type_list = [{
              PriceKey: @price_types.first.price_key,
              NrOfSeats: 2
            }]
            puts "Client: #{@client.inspect}"
            puts "---------------------------------------"
            puts @price_types.first.inspect
            @price = @price_types.first.price
            @reservation = @section.make_reservation(affiliate: 'test', price_type_list: price_type_list, first_name: 'Joe', last_name: 'Sixpack', email: 'jack@example.com')
          end

          it "returns a Reservation" do
            expect(@reservation).to be_a ShakeTheCounter::Reservation
          end

          it "has a reservation_key" do
            expect(@reservation.key).to be_a String
            expect(@reservation.key.length).to be > 31
          end

          describe "client#find_reservation" do
            before(:all) do
              client = ShakeTheCounter::Client.new
              @found_reservation = client.find_reservation(@reservation.key)
            end

            it 'finds a reservation' do  
              expect(@found_reservation).to be_a ShakeTheCounter::Reservation
            end

            it 'has the same key' do  
              expect(@found_reservation.key).to eq @found_reservation.key
            end
          end

          describe "#start_payment and #confirm_reservation" do
            before(:all) do
              @client = ShakeTheCounter::Client.new
            end

            it 'returns true for start_payment' do  
              @result = @client.start_payment(@reservation.key)
              expect(@result).to eq true
            end
            
            it 'receives tickets after #confirm_reservation' do
              @tickets = @client.confirm_reservation(reservation_key: @reservation.key, payment_method: 'API Test', amount_paid: @price.to_f*2)
              expect(@tickets).to be_an Array
            end
            

          end

          

        end

      end
    end
  end

end
