module ShakeTheCounter

  # Sets up a performance object
  class Performance

    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :external_performance_id
    attr_accessor :raw_data
    attr_accessor :event

    # Sets up a new event
    # 
    def initialize(args={}, event: nil)
      self.key = args["PerformanceKey"]
      self.name = args["PerformanceName"]
      self.description = args["PerformanceDescription"]
      self.external_performance_id = args["ExternalPerformanceID"]
      self.raw_data = args
      self.event = event
    end

    # 
    # GET /api/v1/event/{eventKey}/performance/{performanceKey}/sections/{languageCode}
    # Get available sections, pricetypes and prices of the selected performance
    # 
    # @return Array of sections
    def sections
      return @sections if @sections
      @sections = []
      path = "event/#{event.key}/performance/#{key}/sections/#{event.client.language_code}"
      result = event.client.call(path, http_method: :get)
      for section in result
        @sections << ShakeTheCounter::Section.new(section, performance: self)
      end
      return @sections
    end

  end
end
