module ShakeTheCounter

  # Sets up a client to work with
  class Client
    attr_accessor :refresh_token
    attr_accessor :id
    attr_accessor :secret
    attr_accessor :language_code


    # 
    # There are two ways to setup a new client:
    # 1. Initialize with options `(Client.new(client_id: x)`)
    # 2. Initilize without options, get options from config
    # 
    def initialize(args=nil)
      if args.nil?
        init! 
        reset!
      else
        args.each do |key,value|
          instance_variable_set("@#{key}", value)
        end
      end
    end

    # Set's the default value's
    # @return [Hash] configuration options
    def init!
      @defaults = {
        :@refresh_token => ShakeTheCounter::Config.refresh_token,
        :@id            => ShakeTheCounter::Config.client_id,
        :@secret        => ShakeTheCounter::Config.client_secret,
        :@language_code => ShakeTheCounter::Config.language_code,
      }
    end

    # Resets the value's to there previous value (instance_variable)
    # @return [Hash] configuration options
    def reset!
      @defaults.each { |key, value| instance_variable_set(key, value) }
    end

    # 
    # Retrieves a new authentication token to use for this client
    # or reuse the same one from memory.
    # 
    def access_token
      @access_token ||= ShakeTheCounter::Authentication.renew_access_token(client_id: id, client_secret: secret, refresh_token: refresh_token)["access_token"]
    end


    # 
    # Make an API with access_token
    # 
    def call(path, http_method: :get, body: {}, header: {})
      # add bearer token to header
      header[:authorization] = "Bearer #{access_token}"
      return ShakeTheCounter::API.call(path, http_method: http_method, body: body, header: header)
    end

    # 
    # Fetches a list of events for this client
    #  /api/v1/events/available/{languageCode}
    # 
    # @return Array
    def events
      return @events if @events
      @events = []
      path = "events/available/#{language_code}"
      result = call(path, http_method: :get)
      for event in result
        @events << ShakeTheCounter::Event.new(event, client: self)
      end
      return @events
    end

    # 
    # Find a reservation
    # GET /api/v1/reservation/{reservationKey}
    # 
    # @return Reservation
    def find_reservation(key)
      path = "reservation/#{key}"
      result = call(path, http_method: :get)
      reservation = ShakeTheCounter::Reservation.new(result)
      return reservation
    end
    alias_method :reservation, :find_reservation

    # 
    # Send a message to STC that a payment
    # has started.
    # 
    # @return String status
    def start_payment(reservation_key)
      path = "reservation/#{reservation_key}/payment"
      result = call(path, http_method: :post)
      if result.code.to_i == 200
        return true
      else
        raise ShakeTheCounterError.new "Payment failed"
      end
    end


    # Confirm the reservation and receive tickets
    # /api/v1/reservation/{reservationKey}/confirm
    # 
    # @return True (or error)
    def confirm_reservation(reservation_key: '', payment_method: '', amount_paid: nil)

      # step 1: confirm
      path = "reservation/#{reservation_key}/confirm"
      body = {
        PaymentMethod: payment_method,
        AmountPaid: amount_paid
      }
      call(path, http_method: :post, body: body.to_json)

      # step 2: get tickets
      # GET /api/v1/reservation/{reservationKey}/tickets
      path = "reservation/#{reservation_key}/tickets"
      result = call(path, http_method: :get)

      # define new list
      list = []

      for ticket in result
        list << ShakeTheCounter::Ticket.new(ticket)
      end
      return list
    end

  end
end
