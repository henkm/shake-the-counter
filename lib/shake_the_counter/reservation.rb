module ShakeTheCounter

  # Describes a reservation
  class Reservation
  	attr_accessor :reservation_key
		attr_accessor :nr_of_tickets
		attr_accessor :contact_key
		attr_accessor :affiliate
		attr_accessor :reservation_number
		attr_accessor :currency
		attr_accessor :external_reservation_number
		attr_accessor :currency_code
		attr_accessor :basket_key
		attr_accessor :total_amount
		attr_accessor :status
		attr_accessor :ticket_amount
		attr_accessor :reservation_date
		attr_accessor :original_ticket_amount
		attr_accessor :confirmed_date
		attr_accessor :reservation_costs_per_ticket
		attr_accessor :tickets_url
		attr_accessor :reservation_costs_per_transaction
		attr_accessor :payment_method
		attr_accessor :payment_costs
		attr_accessor :is_paid
		attr_accessor :discount
		attr_accessor :is_confirmed
		attr_accessor :discount_title
		attr_accessor :is_blocked

		attr_accessor :raw_data 

    # Sets up a new reservation
    # 
    def initialize(args={})
    	args.each do |key, value|
    		instance_variable_set("@#{key.underscore}", value)
    	end
      self.raw_data = args
    end

    def key
    	reservation_key
    end




  end
end
