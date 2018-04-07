module ShakeTheCounter

  # Sets up a contact object
  class Contact

    attr_accessor :key
    attr_accessor :raw_data

    def initialize(args={}, performance: nil)
      self.key = args["ContactKey"]
      self.raw_data = args
    end

  end
end
