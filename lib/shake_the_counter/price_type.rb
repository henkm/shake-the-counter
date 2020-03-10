module ShakeTheCounter

  # Sets up a PriceType
  class PriceType

    attr_accessor :key
    attr_accessor :price_key
    attr_accessor :product_code
    attr_accessor :name
    attr_accessor :ticket_valid_from
    attr_accessor :ticket_valid_to
    attr_accessor :phone_number_required
    attr_accessor :full_address_required
    attr_accessor :price
    attr_accessor :requires_capacity_slot

    attr_accessor :section
    attr_accessor :raw_data

    # Sets up a new price type
    # 
    def initialize(args={}, section: nil)
      self.section = section
      self.key = args["PriceTypeKey"]
      self.price_key = args["PriceKey"]
      self.name = args["PriceTypeName"]
      self.ticket_valid_from = DateTime.parse(args["TicketValidFrom"]) if args["TicketValidFrom"]
      self.ticket_valid_to = DateTime.parse(args["TicketValidTo"]) if args["TicketValidTo"]
      self.phone_number_required = args["PhoneNumberRequired"]
      self.full_address_required = args["FullAddressRequired"]
      self.price = args["Price"].to_f
      self.requires_capacity_slot = args["RequiresCapacitySlot"]
      self.raw_data = args     
    end

  end
end
