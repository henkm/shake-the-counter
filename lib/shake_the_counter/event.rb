module ShakeTheCounter

  # Sets up an event object
  class Event
    attr_accessor :key
    attr_accessor :name
    attr_accessor :performer
    attr_accessor :tagline
    attr_accessor :blocked_countries_for_sales
    attr_accessor :rating
    attr_accessor :review_count
    attr_accessor :currency
    attr_accessor :lowest_price
    attr_accessor :performances
    attr_accessor :raw_data
    attr_accessor :client


    # Sets up a new event
    # 
    def initialize(args={}, client: nil)
      self.client = client
      self.key = args["EventKey"]
      self.name = args["EventName"]
      self.performer = args["Performer"]
      self.tagline = args["Tagline"]
      self.blocked_countries_for_sales = args["BlockedCountriesForSales"]
      self.rating = args["Rating"]
      self.review_count = args["ReviewCount"]
      self.currency = args["Currency"]
      self.lowest_price = args["LowestPrice"]
      self.performances = []
      for perf in args["Performances"]
        self.performances << ShakeTheCounter::Performance.new(perf, event: self)
      end
      self.raw_data = args
      
    end

  end
end
