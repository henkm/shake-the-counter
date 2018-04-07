module ShakeTheCounter

  # Describes a ticket
  class Ticket

    # Sets up a new reservation
    # 
    def initialize(args={})
      args.each do |key, value|
        # {"TicketKey"=>"1539335d-865d-40eb-ac31-0ac4b687ef2e", "Currency"=>"EUR", "Price"=>6.0, "PriceTypeKey"=>"0e9e2088-f74a-4ef4-9fe4-e668f2a01241", "PriceTypeName"=>"55 Plus", "ExternalPriceTypeID"=>"", "BranchePriceID"=>nil, "SectionName"=>"Toegangskaart", "TicketCode"=>"9787821683696", "BarcodeType"=>nil, "TicketValidFrom"=>"2018-03-31T00:00:00+02:00", "TicketValidTo"=>"2018-10-28T23:59:00+01:00", "LastClaimDate"=>nil, "SubscriptionProductKey"=>"00000000-0000-0000-0000-000000000000", "ScanningDisplayMessage"=>"", "TicketText"=>nil, "SalesChannelName"=>nil, "ExternalPriceID"=>nil}
        singleton_class.class_eval { attr_accessor key.underscore }
        instance_variable_set("@#{key.underscore}", value)
      end
    end

    def key
      reservation_key
    end




  end
end
