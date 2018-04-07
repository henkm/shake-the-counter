module ShakeTheCounter

  # Sets up a section object
  class Section

    attr_accessor :key
    attr_accessor :performance_section_key
    attr_accessor :name
    attr_accessor :available_seats
    attr_accessor :price_types
    attr_accessor :performance
    attr_accessor :raw_data
    attr_accessor :price_types    

    # Sets up a new section
    # 
    def initialize(args={}, performance: nil)
      self.key = args["SectionKey"]
      self.name = args["SectionName"]
      self.performance_section_key = args["PerformanceSectionKey"]
      self.available_seats = args["AvailableSeats"]
      self.performance = performance
      self.price_types = []
      for price_type in args["PriceTypes"]
        self.price_types << ShakeTheCounter::PriceType.new(price_type, section: self)
      end
      self.raw_data = args
    end

    # 
    # Makes a reservation for this section
    # POST /api/v1/event/{eventKey}/performance/{performanceKey}/section/{performanceSectionKey}/reservation/{languageCode}
    # @param email: '' [type] [description]
    # 
    # @return Reservation
    def make_reservation(price_type_list: {}, affiliate: '', first_name: '', last_name: '', email: '')
      # step 1: make the reservation
      path = "event/#{performance.event.key}/performance/#{performance.key}/section/#{performance_section_key}/reservation/#{performance.event.client.language_code}"
      body = { 
        PriceTypeList: price_type_list
      }
      result = performance.event.client.call(path, http_method: :post, body: body.to_json)
      reservation = ShakeTheCounter::Reservation.new(result)

      # step 2: create a contact
      path = "contact/#{performance.event.client.language_code}"
      body = { 
        FirstName: first_name,
        LastName: last_name,
        MailAddress: email,
        LanguageCode: performance.event.client.language_code
      }
      result = performance.event.client.call(path, http_method: :post, body: body.to_json)
      contact = ShakeTheCounter::Contact.new(result)      

      # step 3: link contact to the reservation
      path = "reservation/#{reservation.key}/contact"
      body = {
        ContactKey: contact.key
      }
      result = performance.event.client.call(path, http_method: :post, body: body.to_json)

      return reservation
    end

  end
end
