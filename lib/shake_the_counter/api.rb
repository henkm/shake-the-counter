module ShakeTheCounter

  # The communication layer implements all the methods available in the ShakeTheCounter API
  # https://ticketstest.ticketcounter.nl/swagger/ui/index
  class API

    # 
    # Returns the API endpoint to use
    # 
    # @return [type] [description]
    def self.endpoint
      if ShakeTheCounter::Config.environment.to_s == "test"
        # "https://apitest.shakethecounter.com"
        "https://apitest.ticketcounter.nl"
      elsif ShakeTheCounter::Config.environment.to_s == "staging"
        # "https://apitest.shakethecounter.com"
        "https://apiacpt.ticketcounter.nl"
      else
        # "https://apitest.shakethecounter.com"
        "https://api.ticketcounter.nl"
      end
    end


    # 
    # Returns the complete API URL 
    # 
    def self.url(path)
      # Don't change the path if it already is a full url
      if path.include?('http')
        return path
      else
        "#{endpoint}/api/v#{ShakeTheCounter::Config.version}/#{path}"
      end
    end

    # 
    # Makes a HTTP POST call to the endpoint en returns the response
    # 
    # @param request_body [type] [description]
    # @param request_identifier [type] [description]
    # 
    # @return OpenStruct object with nested methods.
    def self.call(path, http_method: :get, body: {}, header: {})
      values = body
      header[:accept] = "application/json" 

      unless header[:content_type]
        if body && body != {}
          header[:content_type] = "application/json" 
        else
          # blank body requires no JSON
          header[:content_type] = "application/x-www-form-urlencoded" 
        end
      end

      begin
        if ShakeTheCounter::Config.verbose
          puts "Calling #{http_method.upcase} to #{url(path)}"
          puts "Header: #{header.to_json}"
          puts "Body:"
          puts body
        end
        if http_method == :post
          response = RestClient.post url(path), values, header
        else
          response = RestClient.get url(path), header
        end
      rescue RestClient::ExceptionWithResponse => e
        raise ShakeTheCounterError.new "#{e} #{e.response}"
      end
      if ShakeTheCounter::Config.verbose
        puts "Result:\n#{response.inspect.to_s}"
      end
      if response.body != ''
        object =  JSON.parse(response.body)
      else
        object = response
      end
      return object
    end

    # 
    # Checks the connection
    # GET /api/v1/ping
    # 
    def self.ping
      call("ping", http_method: :get)
    end


  end
end
